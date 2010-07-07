require File.dirname(__FILE__) + '/connection'

class LiteQuery

     def initialize
        @data_base = Connection.new.data_base
     end

     def raw_query(query)
       return if !@data_base.complete? query    #SOMEBODY SAVE ME FROM MYSELF
       @data_base.execute(query)
     end

     def insert_resource_values_to_set(set, name, value)
         @data_base.execute("insert into resource_pairs values (?, ?, ?, ?)" , 666, set, name, value)
     end

     def insert_resource_values(name, value)
          @data_base.execute("insert into resource_pairs values (?, ?, ?, ?)", 6666, 1, name, value)
     end

     def insert_save(file)
          @data_base.execute("insert into save values (?,?)", 6667, file)
     end

     def remove_save_by_name(save_file)
         @data_base.execute("delete from save where save_file == #{save_file}")
     end

     def remove_save_by_key(key)
        @data_base.execute("delete from save where save_key == #{key}")
     end

     def update_resource_values(id, field, value)
        @data_base.execute("update resource_pairs where resource_key == id set #{field} = #{value}")
     end

     def get_all_resources
       return @data_base.execute('select * from resource_pairs')
     end

     def get_resource_set(set)
       return @data_base.execute("select * from resource_pairs where resx_set_key == #{set}")
     end

     def get_saves
       return @data_base.execute('select * from save')
     end
end
