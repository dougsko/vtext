require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Vtext" do
  it "sends a text" do
    username = ""
    password = ""
    cell = ""

    vtext = Vtext.new('username' => username, 'password' => password, 'cell_num' => cell)
    res = vtext.send('test')
    res.string.should match(/^250/)
  end
end
