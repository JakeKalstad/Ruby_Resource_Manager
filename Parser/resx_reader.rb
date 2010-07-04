class Resx_Reader

  def initialize(file_name)
    file = File.open(file_name, "r")
    @lines = file.readlines
  end

  def read_lines
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

  def is_empty
    @lines.each_index {|line|
                          if @lines[line].include? '<data name='
                          return false
                          end
                       }
  end
end