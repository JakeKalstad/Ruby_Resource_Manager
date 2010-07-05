require File.dirname(__FILE__) + "/../Read/read_save"
class Save
  def initialize(file_path_to_save)

     @file_path = file_path_to_save
     @file_content = Array.new
     @save_location = 'saved_jobs.wtf'
     
      if !first_time_check
         @file = File.open(@save_location, 'w')
      end
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
    contents = Read.new.receive_file_contents
    content = @file_path.split("\\").last
    @file_content << content
    @file_content += contents
    @file_content.each_index { |index|
                               @file.puts @file_content[index]
                                @file.close_write
                              }
  end
end