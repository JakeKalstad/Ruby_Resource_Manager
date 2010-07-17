require File.dirname(__FILE__) + "../../../SQLite/lite_query"
require File.dirname(__FILE__) + "../../../SQLIte/table_extension"

class Save
  def initialize(file_path_to_save, current_set)
     @path = file_path_to_save
     @current_set = current_set
     @query = LiteQuery.new
     return update_database if !table_already_contains_path

     reload_feign_data
  end

 private 
  def update_database
     @save_id = @query.get_unattached_save
     @query.insert_save(@path, @current_set)
     @tuples = Node_Manufacturer.new(@path).resource_tuple_list

     @tuples.each_index { |i|
      return if @query.resource_exists(Table_Extension.get_resource_tuple_value(@tuples[i]))

      @query.insert_resource_values(@save_id, Table_Extension.get_resource_tuple_name(@tuples[i]),
                                            Table_Extension.get_resource_tuple_value(@tuples[i]))
                       }
  end

  def reload_feign_data
      return if @deleted_key == nil
      @query.update_deleted_save(@deleted_key)
  end

  def table_already_contains_path
      previous_saves = @query.get_saves
      previous_saves.each_index { |i|
                                      if previous_saves[i].include? @path
                                          @existent = true
                                          @deleted_key = Table_Extension.get_save_key(previous_saves, i)
                                       end
                                 }
      return @existent
    end
end