require 'rjb'
require 'tempfile'

module Propaganda    
  class Fop
    def initialize(verbose=false)
      unless verbose
      end
    end

    def version
      invoke('-v')
      Output.toString 
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
      tmp = nil  
    end
    
    private 
    
    def invoke(*args)
      # When invoking we need to use our own Manager class because the default
      # cli Main class deletes the file on exit and always calls System.exit 
      # which closes our application. We avoid that and also setup additional
      # protection against rogue System.exit calls in the library
      SystemExitManager.disableSystemExitCall
      Manager._invoke('main', '[Ljava.lang.String;', args)
    rescue Exception => e
      raise "Could not render document [#{e}] (" + Errors.toString + ")"
    ensure  
      SystemExitManager.enableSystemExitCall
    end
        
    def self.classpath
      path = File.join(File.dirname(__FILE__), '..', '..', 'java')
      File.expand_path(path+':'+File.join(path, 'fop.jar'))
    end
    
    Rjb::load(Fop.classpath, ['-Djava.awt.headless=true'])
    SystemExitManager = Rjb::import 'SystemExitManager'    
    Manager = Rjb::import 'org.apache.fop.cli.Manager'    
    ByteArray = Rjb::import 'java.io.ByteArrayOutputStream'
    PrintStream = Rjb::import 'java.io.PrintStream'

    # Internally fop is very noisy, we have to block all of that if we don't
    # want to go crazy. To do that we overwrite the default streams
    Errors = ByteArray.new
    Rjb::import('java.lang.System').err = PrintStream.new(Errors)
    Output = ByteArray.new
    Rjb::import('java.lang.System').out = PrintStream.new(Output)
  end
end