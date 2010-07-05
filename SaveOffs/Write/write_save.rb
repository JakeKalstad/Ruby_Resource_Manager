require File.dirname(__FILE__) + "/../SaveOffs/file_dialog"
class Save
  def initialize(file_path_to_save)
     @file_path = file_path_to_save

     @file = File.Open(@file_path)if !first_time_check
     @@save_location = 'saved_jobs.wtf'
     append_and_write
  end

  def first_time_check
    if !File.exist?(@@save_location)
      File.new(@@save_location, 'w')
      return true
    end
      return false
  end

  def append_and_write
    contents = Read.receive_file_contents(@@save_location)
    contents.push(@file_path)
    contents.each_index { |index| @file.puts contents[index]}
  end

end