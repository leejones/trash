require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Trash" do
  def delete(file)
    FileUtils.rm_rf(file)
  end
  
  def delete_from_trash(file)
    delete("#{ENV['HOME']}/.Trash/#{file}")
  end

  def trash_should_contain(file_name)
    File.exist?("#{ENV['HOME']}/.Trash/#{file_name}").should == true    
  end

  def trash_should_contain_directory(directory_name)
    File.directory?(directory_name)
    trash_should_contain(directory_name)
  end
  
  def tmp_should_not_contain(file_name)
    File.exist?("/tmp/#{file_name}").should == false
  end

  it "moves a file to the trash" do
    `echo 'default text' > /tmp/testing.txt`
    Trash.new.throw_out("/tmp/testing.txt")
    tmp_should_not_contain "testing.txt"
    trash_should_contain "testing.txt"
    delete_from_trash "testing.txt"
  end
  
  it "moves multiple files to the trash" do
    `echo 'default text first' > /tmp/testing.txt`
    `echo 'default text second' > /tmp/testing2.txt`
    Trash.new.throw_out(*["/tmp/testing.txt", "/tmp/testing2.txt"])
    tmp_should_not_contain "testing.txt"
    tmp_should_not_contain "testing2.txt"
    trash_should_contain "testing.txt"
    trash_should_contain "testing2.txt"
    delete_from_trash "testing.txt"
    delete_from_trash "testing2.txt"
  end

  it "should handle spaces in the file/directory name" do
    create_file = `echo "Test with spaces..." > "/tmp/test with spaces.txt"`
    Trash.new.throw_out("/tmp/test with spaces.txt")
    tmp_should_not_contain "test with spaces.txt"
    trash_should_contain "test with spaces.txt"
    delete_from_trash "\"test with spaces.txt\""
  end

  it "appends a number to the filename if a file with same name already exisits in trash" do
    `echo 'default text' > /tmp/testing.txt`
    Trash.new.throw_out("/tmp/testing.txt")
    tmp_should_not_contain "testing.txt"
    trash_should_contain "testing.txt"
    original = File.new("#{ENV['HOME']}/.Trash/testing.txt", "r")
    original.read.should == "default text\n"
    
    `echo 'testing different file with same name' > /tmp/testing.txt`
    Trash.new.throw_out("/tmp/testing.txt")
    tmp_should_not_contain "testing.txt"
    trash_should_contain "testing01.txt" 
    third = File.new("#{ENV['HOME']}/.Trash/testing01.txt", "r")
    third.read.should == "testing different file with same name\n"
  
    `echo 'testing different file 2 with same name' > /tmp/testing.txt`
    Trash.new.throw_out("/tmp/testing.txt")
    tmp_should_not_contain "testing.txt"
    trash_should_contain "testing02.txt"
    fourth = File.new("#{ENV['HOME']}/.Trash/testing02.txt", "r")
    fourth.read.should == "testing different file 2 with same name\n"

    `echo 'testing different file 3 with same name' > /tmp/testing.txt`
    Trash.new.throw_out("/tmp/testing.txt")
    tmp_should_not_contain "testing.txt"
    trash_should_contain "testing03.txt"
    fifth = File.new("#{ENV['HOME']}/.Trash/testing03.txt", "r")
    fifth.read.should == "testing different file 3 with same name\n"
    
    delete_from_trash "testing.txt"
    delete_from_trash "testing01.txt"
    delete_from_trash "testing02.txt"
    delete_from_trash "testing03.txt"
  end
  
  it "should throw an error when file does not exist" do
    tmp_should_not_contain "not_a_file.txt"
    trash = Trash.new
    trash.throw_out("/tmp/not_a_file.txt").should == 1
    trash.errors.join(' ').should == "/tmp/not_a_file.txt does not exist.  Please check the file path."
  end
  
  it "moves a directory to the trash" do
    FileUtils.mkdir_p("/tmp/testdir01")
    Trash.new.throw_out("/tmp/testdir01")
    tmp_should_not_contain "testdir01"
    trash_should_contain_directory "testdir01"
    delete_from_trash "testdir01"
  end

  it "moves multiple directories to the trash" do
    FileUtils.mkdir_p %w(/tmp/testdir01 /tmp/testdir02)
    Trash.new.throw_out(*["/tmp/testdir01", "/tmp/testdir02"])
    tmp_should_not_contain "testdir01"
    tmp_should_not_contain "testdir02"
    trash_should_contain_directory "testdir01"
    trash_should_contain_directory "testdir02"
    delete_from_trash "testdir01"
    delete_from_trash "testdir02"
  end
  
  it "handles dots in a directory name" do
    FileUtils.mkdir_p("/tmp/testdir.2010")
    Trash.new.throw_out("/tmp/testdir.2010")
    tmp_should_not_contain "testdir.2010"
    trash_should_contain_directory "testdir.2010"

    FileUtils.mkdir_p("/tmp/testdir.2010")
    Trash.new.throw_out("/tmp/testdir.2010")
    tmp_should_not_contain "testdir.2010"
    trash_should_contain_directory "testdir.201001"
    
    delete_from_trash "testdir.2010"
    delete_from_trash "testdir.201001"
  end


  it "appends a number to the directory name if a directory with same name already exisits in trash" do
    FileUtils.mkdir_p("/tmp/testing")
    Trash.new.throw_out("/tmp/testing")
    tmp_should_not_contain "testing"
    trash_should_contain_directory "testing"
    
    FileUtils.mkdir_p("/tmp/testing")
    Trash.new.throw_out("/tmp/testing")
    tmp_should_not_contain "testing"
    trash_should_contain_directory "testing01" 
  
    FileUtils.mkdir_p("/tmp/testing")
    Trash.new.throw_out("/tmp/testing")
    tmp_should_not_contain "testing"
    trash_should_contain_directory "testing02" 

    FileUtils.mkdir_p("/tmp/testing")
    Trash.new.throw_out("/tmp/testing")
    tmp_should_not_contain "testing"
    trash_should_contain_directory "testing03" 
    
    delete_from_trash "testing"
    delete_from_trash "testing01"
    delete_from_trash "testing02"
    delete_from_trash "testing03"
  end

  describe "trash_can" do
    it "finds the trash can" do
      FileUtils.mkdir_p "#{ENV['HOME']}/.Trash"
      Trash.new.has_trash_can?.should == true
    end

    it "creates a trash can if one does not exist" do
      delete("/tmp/test_trash_can")
      File.exist?("/tmp/test_trash_can").should == false
      oscar = Trash.new({:trash_can => "/tmp/test_trash_can"})
      File.exist?("/tmp/test_trash_can").should == true
      File.directory?("/tmp/test_trash_can").should == true
      delete("/tmp/test_trash_can")
    end
  end
  
end
