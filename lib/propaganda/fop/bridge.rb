require 'rjb'

module Propaganda    
  module Fop
    class Bridge
      def initialize(verbose=false)
        @verbose = verbose
      end
      
      def invoke(*args)
        # When invoking we need to use our own Manager class because the default
        # cli Main class deletes the file on exit and always calls System.exit 
        # which closes our application. We avoid that and also setup additional
        # protection against rogue System.exit calls in the library
        SystemExitManager.disableSystemExitCall
        Manager._invoke('main', '[Ljava.lang.String;', args)
        Output.toString
      rescue Exception => e
        raise "Could not render document [#{e}] (" + Errors.toString + ")"
      ensure  
        SystemExitManager.enableSystemExitCall
      end
          
      private 
      
      def self.classpath
        path = File.join(File.dirname(__FILE__), '..', '..', '..', 'java')
        File.expand_path(path)+':'+File.join(path, 'fop.jar')
      end
      
      Rjb::load(Bridge.classpath, ['-Djava.awt.headless=true'])
      SystemExitManager = Rjb::import 'SystemExitManager'    
      Manager = Rjb::import 'org.apache.fop.cli.Manager'    
      ByteArray = Rjb::import 'java.io.ByteArrayOutputStream'
      PrintStream = Rjb::import 'java.io.PrintStream'

      # Internally fop is very noisy, we have to block all of that if we don't
      # want to go crazy. To do that we overwrite the default streams, 
      # unfortunately these are globals, so its one size fits all
      Errors = ByteArray.new
      Rjb::import('java.lang.System').err = PrintStream.new(Errors)
      Output = ByteArray.new
      Rjb::import('java.lang.System').out = PrintStream.new(Output)
    end
  end
end