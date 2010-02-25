require 'tempfile'

module Propaganda    

  def self.check_dependencies
    require 'propaganda/fop/shell' 
    require 'propaganda/fop/bridge'
  end

  MODE = check_dependencies ? 'rjb' : 'shell'

  class Renderer
    def initialize(verbose=false)
      @verbose = verbose
    end

    def version
      invoke('-v')
    end

    def render(html, output, template=nil)
      template ||= 'default'
      stylesheet = File.join(File.dirname(__FILE__), '..', '..', 'templates', "#{template}.xsl")
      stylesheet = File.expand_path(stylesheet)
      tmp = Tempfile.new('fop')
      tmp << html
      tmp.flush
      tmp.close
      output = File.expand_path(output)
      invoke('-xml', tmp.path, '-xsl', stylesheet, '-pdf', output)
    ensure
      tmp.close rescue nil
      tmp = nil  
    end
    
    private 
    
    def invoke(*args)
      if MODE == 'rjb'
        fop = Propaganda::Fop::Bridge.new(@verbose)
        fop.invoke(*args)
      elsif MODE == 'shell'
        fop = Propaganda::Fop::Shell.new(@verbose)
        fop.invoke(*args)
      end
    end        
  end
end