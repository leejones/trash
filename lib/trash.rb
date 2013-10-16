require 'fileutils'

class Trash
  attr_reader :errors
  attr_accessor :trash_can
  
  def initialize(options = {:trash_can => "#{ENV['HOME']}/.Trash"})
    @trash_can = options[:trash_can]
    create_trash_can_if_absent
    @errors = []
  end

  def has_trash_can?
    File.directory? @trash_can 
  end
  
  def throw_out(*paths)
    paths.each do |path|
      path = File.expand_path(path)
      if File.exist? path
        FileUtils.mv(path, "#{@trash_can}/#{unique_file_name(path)}")
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
  
  def create_trash_can_if_absent
    FileUtils.mkdir_p(@trash_can) unless has_trash_can?
  end
  
  def unique_file_name(path)
    file_name      = File.split(path).last
    file_extension = File.extname(path)

    return file_name unless File.exists?("#{@trash_can}/#{file_name}")

    if File.directory? path
      unique_file_name_finder { |c| "#{file_name}#{"%02d" % c}" }
    else
      unique_file_name_finder { |c| "#{file_name.gsub(file_extension, "#{"%02d" % c}#{file_extension}")}" }
    end
  end
  
  def unique_file_name_finder
    count = 1
    while File.exists?("#{@trash_can}/#{yield(count)}")
      count += 1
    end
    return yield(count)
  end
  
end