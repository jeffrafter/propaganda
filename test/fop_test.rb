require 'helper'

class FopTest < Test::Unit::TestCase
  should "render a formatting object document to pdf" do
    File.delete('test/samples/sample.pdf') rescue nil
    assert File.exists?('test/samples/sample.html')
    text = IO.read('test/samples/sample.html')
    fop = Propaganda::Renderer.new(true)
    fop.render(text, 'test/samples/sample.pdf')
    assert File.exists?('test/samples/sample.pdf') 
  end

  should "get the version" do
    fop = Propaganda::Renderer.new
    assert fop.version
  end
end
