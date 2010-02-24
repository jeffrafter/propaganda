require 'redcloth'
require 'bluecloth'

module Propaganda
  class Formatter
    def format(text, title=nil, engine=nil)
      case engine
        when 'markdown'
          text = BlueCloth.new(text).to_html
          text = layout(text, title)
        when 'textile'
          r = RedCloth.new(text)
          r.hard_breaks = false
          text = r.to_html
          text = layout(text, title)
        else
          text
      end        
    end
    
    private
    
    def layout(text, title=nil)
      "<html xmlns='http://www.w3.org/1999/xhtml'>
        <head>
          <meta http-equiv='Content-type' content='text/html; charset=utf-8' />   
          <title>#{title}</title>
        </head>
        <body>
          #{text}
        </body>
      </html>"
    end
  end
end