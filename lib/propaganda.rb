require 'propaganda/fop'
require 'propaganda/formatter'

module Propaganda
  def self.convert(input, output, title=nil, template=nil, engine=nil, verbose=false)
    title ||= File.basename(input, File.extname(input))
    engine ||= detect(input)
    text = IO.read(input)
    formatter = Formatter.new
    text = formatter.format(text, title, engine)
    fop = Fop.new(verbose)
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