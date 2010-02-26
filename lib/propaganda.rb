require 'propaganda/renderer'
require 'propaganda/formatter'

module Propaganda
  def self.convert(input, output, title=nil, template=nil, engine=nil, format=nil, verbose=false)
    title ||= File.basename(input, File.extname(input))
    engine ||= detect(input)
    format ||= 'pdf'
    text = IO.read(input)
    formatter = Formatter.new
    text = formatter.format(text, title, engine)
    return !File.open(output, 'w') {|f| f.write(text) }.nil? if format == 'html'
    fop = Renderer.new(verbose)
    fop.render(text, output, template)
  end
  
  def self.detect(input)
    case File.extname(input)
      when '.textile'
        'textile'
      when '.markdown', '.md'
        'markdown'
      when '.html', '.xhtml'
        'none'
      else
        raise "Unknown format for #{input}, use .html, .textile or .markdown extension"
    end
  end

end