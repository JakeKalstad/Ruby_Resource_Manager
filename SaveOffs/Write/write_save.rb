require File.dirname(__FILE__) + "../../../SQLite/lite_query"

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
    @tuples = Node_Manufacturer.new(@path).resource_tuple_list
    @tuples.each_index { |i| @query.insert_resource_values(@tuples[i][0], @tuples[i][1]) }
  end

  def table_already_contains_path
    previous_saves = @query.get_saves
    previous_saves.each_index { |i| @existent = true if previous_saves[i].include? @path }
    return @existent
  end
end