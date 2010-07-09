require File.dirname(__FILE__) + "../../../SQLite/lite_query"
require File.dirname(__FILE__) + "../../../SQLIte/table_extension"

class Save

  def initialize(file_path_to_save)
     @path = file_path_to_save
     @query = LiteQuery.new
     if !table_already_contains_path
       update_database()
     end
  end
  
  def update_database
    @query.insert_save(@path)
    p 'hm...'
    @tuples = Node_Manufacturer.new(@path).resource_tuple_list
    p @tuples
    @tuples.each_index { |i| @query.insert_resource_values(Table_Extension.get_resource_tuple_name(@tuples[i]), Table_Extension.get_resource_tuple_value(@tuples[i])) }
  end

  def table_already_contains_path
    previous_saves = @query.get_saves
    previous_saves.each_index { |i| @existent = true if previous_saves[i].include? @path }
    return @existent
  end
end