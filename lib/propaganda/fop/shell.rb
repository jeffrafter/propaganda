require 'open3'

module Propaganda    
  module Fop
    class Shell
      def initialize(verbose=false)
        @verbose = verbose
      end
      
      def invoke(*args)
        command = "java -Djava.awt.headless=true -jar #{jarpath} #{args.join(' ')}"
        if @verbose
          `#{command}`
        else
          stdin, stdout, stderr = Open3.popen3(command)
          @errors = stderr.read
          @output = stdout.read
          @output
        end  
      end

      private 
      
      def jarpath
        path = File.join(File.dirname(__FILE__), '..', '..', '..', 'java')
        File.expand_path(File.join(path, 'fop.jar'))
      end
      
    end
  end
end