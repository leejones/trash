require 'fileutils'

class Trash
  attr_reader :errors
  attr_accessor :trashcan
  
  def initialize(options = {})
    @trashcan = options[:trashcan].nil? ? "#{ENV['HOME']}/.Trash" : options[:trashcan]
    create_trashcan_if_absent
    @errors = []
  end

  def has_trashcan?
    File.directory? @trashcan 
  end
  
  def throw_out(paths)
    paths.each do |path|
      path = File.expand_path(path)
      if File.exist? path
        FileUtils.mv(path, "#{ENV['HOME']}/.Trash/#{unique_file_name(path)}")
      else
        add_error "#{path} does not exist.  Please check the file path."
        return 1
      end
    end
    
    return 0
  end
  
  def add_error(error)
    @errors << error
  end
  
  private
  
  def create_trashcan_if_absent
    FileUtils.mkdir_p @trashcan unless has_trashcan?
  end
  
  def unique_file_name(path)
    path_name = File.basename(path)
    path_extension = File.extname(path)
    if (File.exists?("#{ENV['HOME']}/.Trash/#{path_name}"))
      count = 1
      while File.exists?("#{ENV['HOME']}/.Trash/#{path_name.gsub(path_extension, "0#{count}#{path_extension}")}")
        count += 1
      end
      new_path_name = path_name.gsub(path_extension, "0#{count}#{path_extension}")
    end
    return new_path_name
  end
end