require File.dirname(__FILE__) + "/../Read/read_save"
class Save

  def initialize(file_path_to_save)

     @file_path = file_path_to_save
     @file_content = Array.new
     @save_location = 'saved_jobs.wtf'
     @reader = Read.new
     append_and_write

  end

  def first_time_check
    if !File.exist?(@save_location)
      File.new(@save_location, 'w')
      return true
    end
      return false
  end

  def append_and_write
    contents = @reader.receive_file_contents
    @file = File.open(@save_location, 'w')
    contents.each_index { |idx|
                            check = contents[idx].include?(@file_path)
                            @contains = true if check == true
                         }
    contents << @file_path if !@contains
    contents.each_index { |index| @file.puts contents[index] }
    @file.close
  end
end