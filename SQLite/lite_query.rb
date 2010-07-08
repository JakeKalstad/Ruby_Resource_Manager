require File.dirname(__FILE__) + '/connection'

class LiteQuery

     def initialize
        @data_base = Connection.new.data_base
     end

     def insert_resource_values_to_set(set, name, value)
         @data_base.execute("insert into resource_pairs values (?, ?, ?, ?)" , 666, set, name, value)
     end

     def insert_resource_values(name, value)
          @data_base.execute("insert into resource_pairs values (?, ?, ?, ?)", 6666, 1, name, value)
     end

     def insert_save(file)
          @data_base.execute("insert into save values (?,?,?)", 666, 1, file)
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

     def get_resource_set(set_key)
       return @data_base.execute("select * from resource_pairs where resx_set_key == #{set_key}")
     end

     def get_resource_from_current_choice(recent_choice)
        @key = save_set(recent_choice)
        @resources = get_resource_set(@key)
        return @resources
     end

     def save_set(save)
       saves = @data_base.execute("select * from save")
       saves.each_index { |i| @set_key = saves[i][1] if saves[i][2].include? save }
       @set_key
     end

     def get_saves
       return @data_base.execute('select * from save')
     end
end
