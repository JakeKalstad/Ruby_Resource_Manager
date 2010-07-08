class Resx_Reader

  def initialize(file_name)
    @name = File.new(file_name).path
  end
  def read_lines
   open_and_read(@name)

   if is_valid_resx
     if !is_empty
        return @lines
     end
   end
   return Array.new
 end

 private
 def is_valid_resx
   return false if @lines.length < 3
   return true if @lines.each_index { |index| @lines.include?('Microsoft ResX Schema') }
   return false
 end

  def open_and_read(file_name)
    puts File.size(file_name)
    @file = File.open(file_name, 'r')
    @lines = @file.readlines
    @file.close
  end

 def is_empty
   @lines.each_index {|line|
                         if @lines[line].include? '<data name='
                         return false
                         end
                      }


  end
end
