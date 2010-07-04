require 'resx_reader'
class Node_Manufacturer
      attr_accessor :resource_tuple
  def initialize(file_path)
    @resource_tuple = Array.new
    @resource_index = 0
    @reader = Resx_Reader.new(file_path)
    @lines = @reader.read_lines
    create_nodes
    end

  def create_nodes
     return if @lines.length == 0
     @lines.each_index {
                          |line| if @lines[line].include? '<data name=';
                                     if line >= 45;
                                       stuff_tuple_name(line)
                                     end
                                 end
                        }

     @resource_index = 0
     
     @lines.each_index {
                          |line| if @lines[line].include? '<value>';
                                     if line >= 119;
                                       stuff_tuple_value(line)
                                     end
                                 end
                        }
  end

  def stuff_tuple_name(index)
    line_to_string = @lines[index].split('"')
    name_to_stuff = line_to_string[1]
    next_tuple = Struct.new(:name, :value).new
    next_tuple.name = name_to_stuff
    @resource_tuple[@resource_index] = next_tuple
    @resource_index += 1
  end

  def stuff_tuple_value(index)
    return if @resource_index > @resource_tuple.length - 1
    line_to_string = @lines[index].sub('<value>', '')
    line_to_string = line_to_string.sub('</value>', '')
    final_tuple = @resource_tuple.fetch(@resource_index)
    final_tuple.value = line_to_string
    @resource_tuple[@resource_index] = final_tuple
    @resource_index += 1
  end
end

manu = Node_Manufacturer.new('C:/Users/Jake/Desktop/ResourceManager/ResourceManager/Properties/Resources.resx')
puts manu.resource_tuple