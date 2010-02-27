require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TrashCompactor" do
  test_files = [
    "/tmp/testing.txt",
    "/tmp/testing2.txt",
    "/Users/leejones/.Trash/testing.txt",
    "/Users/leejones/.Trash/testing2.txt"
  ]
    
  before do
    test_files.each {|f| `echo 'test' > #{f}`}
  end
  
  after do
    test_files.each {|f| `rm #{f}`}
  end

  def trash_should_contain(file_name)
    File.exist?("#{ENV['HOME']}/.Trash/#{file_name}").should == true    
  end
  
  def tmp_should_not_contain(file_name)
    File.exist?("/tmp/#{file_name}").should == false
  end

  it "moves a file to the trash" do
    Trash.compact!("/tmp/testing.txt")
    tmp_should_not_contain "testing.txt"
    trash_should_contain "testing.txt"
  end
  
  it "moves multiple files to the trash" do
    Trash.compact!("/tmp/testing.txt /tmp/testing2.txt")
    tmp_should_not_contain "testing.txt"
    tmp_should_not_contain "testing2.txt"
    trash_should_contain "testing.txt"
    trash_should_contain "testing2.txt"
  end

  it "appends a number to the filename if a file with same name already exisits in trash" do
    Trash.compact!("/tmp/testing.txt")
    tmp_should_not_contain "testing.txt"
    trash_should_contain "testing.txt"
    `echo 'testing different file with same name' > /tmp/testing.txt`
    Trash.compact!("/tmp/testing.txt")
    tmp_should_not_contain "testing.txt"
    trash_should_contain "testing01.txt"
    f = File.new("/Users/leejones/.Trash/testing.txt", "r")
    f.read.should == "test\n"
    ff = File.new("/Users/leejones/.Trash/testing01.txt", "r")
    ff.read.should == "testing different file with same name\n"
  end

  it "finds the trashcan" do
    Trash.has_trashcan?.should == true
  end
end
