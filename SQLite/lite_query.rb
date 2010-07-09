require File.dirname(__FILE__) + '/connection'

class LiteQuery

     def initialize
        @data_base = Connection.new.data_base
        p @data_base.execute("select * from resource_pairs")
        find_highest_resource_id
     end

     def insert_resource_values_to_set(save_id, set, name, value)
       p @highest
         @data_base.execute("insert into resource_pairs values (?, ?, ?, ?, ?)" , @highest, save_id, set, name, value)
     end

     def insert_resource_values(save_id, name, value)
          @data_base.execute("insert into resource_pairs values (?, ?, ?, ?, ?)", @highest, save_id, 1, name, value)
     end

     def insert_save(file, set)
          @data_base.execute("insert into save values (?,?,?,?)", 1, @highest, set, file)
     end

     def remove_save_by_name(save_file)
         file = save_file.split(' ')[0]
         saves = @data_base.execute("select * from save")
         p saves
         saves.each_index { |i|  if Table_Extension.get_save_display_string(saves, i).include? file
                                                @key = Table_Extension.get_save_key(saves, i)
                                  end
                            }
         remove_save_by_key(@key)
     end

     def remove_save_by_key(key)
       p key
       @data_base.execute("update save set save_key = 666 where save_key == ?", key)
     end

     def update_resource_values(id, field, value)
        @data_base.execute("update resource_pairs where resource_key == ? set ? = ?", id, field, value)
     end

     def get_all_resources
       return @data_base.execute('select * from resource_pairs')
     end

     def get_resource_set(set_key)
       return @data_base.execute("select * from resource_pairs where resx_set_key == ?",set_key)
     end

    def save_set(save)
       saves = get_saves
       saves.each_index { |i| @set_key = saves[i][2] if saves[i][3].include? save }
       @set_key
     end

     def get_saves
       return @data_base.execute('select * from save where save_key != 666')
     end

     def get_unattached_save
      return @data_base.execute("SELECT save_key FROM save, resource_pairs
                                WHERE resource_pairs.save_Fkey == save.save_key")
     end

     def get_resource_from_current_choice(recent_choice)
        @key = save_set(recent_choice)
        @resources = get_resource_set(@key)
        return @resources
     end

    def find_highest_resource_id
      @highest = 0
      @rows = get_all_resources
      @rows.each_index { |i| @highest = rows[i][0] if rows[i][0] > @highest}
    end
end
