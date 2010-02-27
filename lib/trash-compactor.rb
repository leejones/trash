require 'fileutils'

class Trash
  def self.has_trashcan?
    File.directory? "#{ENV['HOME']}/.Trash" 
  end
  
  def self.compact!(file_paths)
    file_paths.split(' ').each do |file_path|
      file_name = File.basename(file_path)
      file_extension = File.extname(file_path)
      if (File.exists?("#{ENV['HOME']}/.Trash/#{file_name}"))
        new_file_name = file_name.gsub(file_extension, "01#{file_extension}")
      else
        new_file_name = file_name
      end
      FileUtils.mv(File.expand_path(file_path), "#{ENV['HOME']}/.Trash/#{new_file_name}")
    end
  end
end