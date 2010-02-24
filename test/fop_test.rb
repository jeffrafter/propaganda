require 'helper'

class FopTest < Test::Unit::TestCase
  should "render a formatting object document to pdf" do
    File.delete('test/samples/sample.pdf') rescue nil
    assert File.exists?('test/samples/sample.html')
    text = IO.read('test/samples/sample.html')
    fop = Propaganda::Fop.new(true)
    fop.render(text, 'test/samples/sample.pdf')
    assert File.exists?('test/samples/sample.pdf'),  Propaganda::Fop::Errors.toString 
  end

  should "get the version" do
    fop = Propaganda::Fop.new
    assert fop.version
  end
end
