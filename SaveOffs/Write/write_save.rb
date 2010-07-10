require File.dirname(__FILE__) + "../../../SQLite/lite_query"
require File.dirname(__FILE__) + "../../../SQLIte/table_extension"

class Save

  def initialize(file_path_to_save, current_set)
     @path = file_path_to_save
     @current_set = current_set
     @query = LiteQuery.new
     if !table_already_contains_path
        return update_database
     end
     reload_feign_data;
  end
  
  def update_database
    @query.insert_save(@path, @current_set)
    @save_id = @query.get_unattached_save
    @tuples = Node_Manufacturer.new(@path).resource_tuple_list
    @tuples.each_index { |i| @query.insert_resource_values(@save_id, Table_Extension.get_resource_tuple_name(@tuples[i]), Table_Extension.get_resource_tuple_value(@tuples[i])) }
    @tuples.each_index { |i| @query.insert_resource_values_to_set(@save_id, @current_set, @tuples[i][0], @tuples[i][1]) }
  end

  def table_already_contains_path
    previous_saves = @query.get_saves
    previous_saves.each_index { |i|
                                    if previous_saves[i].include? @path
                                        @existent = true
                                        @deleted_resource = Table_Extension.get_save_file(previous_saves, i)
                                     end
                               }
    return @existent
  end

  def reload_feign_data
     return if @deleted_resource == nil
     return @deleted_resource
  end

end