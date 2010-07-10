require File.dirname(__FILE__) + '/connection'

class LiteQuery

     def initialize
        @data_base = Connection.new.data_base
        find_highest_resource_id
     end

     def insert_resource_values_to_set(save_id, set, name, value)
         @data_base.execute("insert into resource_pairs values (?, ?, ?, ?, ?)" , @highest, save_id, set, name, value)
         find_highest_resource_id
     end

     def insert_resource_values(save_id, name, value)
          @data_base.execute("insert into resource_pairs values (?, ?, ?, ?, ?)", @highest, save_id, 1, name, value)
          find_highest_resource_id
     end

     def insert_save(file, set)
          @data_base.execute("insert into save values (?,?,?,?)", 1, @highest, set, file)
         find_highest_resource_id
     end

     def remove_save_by_name(save_file)
         file = save_file.split(' ')[0]
         saves = @data_base.execute("select * from save")
         saves.each_index { |i|  if Table_Extension.get_save_display_string(saves, i).include? file
                                                @key = Table_Extension.get_save_key(saves, i)
                                  end
                            }
         remove_save_by_key(@key)
     end

     def remove_save_by_key(key)
       @data_base.execute("update save set save_key = 666 where save_key == ?", key)
     end

     def update_save_by_name(name)
         @data_base.execute("update save set save_key = ? where save_file == ?", @highest, name)
     end

     def update_resource_values(id, field, value)
        @data_base.execute("update resource_pairs where resource_key == ? set ? = ?", id, field, value)
     end

     def get_all_resources
       return @data_base.execute('select * from resource_pairs')
     end

     def get_resource_set
       return @data_base.execute("select * from resource_pairs where resx_set_key == ?", @key)
     end

    def save_set(save)
       saves = get_saves
       saves.each_index { |i| if (saves[i][3].include?(save) && saves[i][0] != $Deleted)
                                @set_key = saves[i][2] 
                              end
                        }
                        end

     def get_saves
       return @data_base.execute('select * from save')
     end

     def get_unattached_save
      return @data_base.execute("SELECT save_key FROM save, resource_pairs
                                WHERE resource_pairs.save_Fkey == save.save_key")
     end

     def get_resource_from_current_choice(recent_choice)
        @key = save_set(recent_choice)[2]
        @resources = get_resource_set
        return @resources
     end

    def find_highest_resource_id
      @highest = 0
      @rows = get_all_resources
      @rows.each_index { |i| @highest = @rows[i][0] if @rows[i][0] != $Deleted && @rows[i][0] > @highest}
    end
end
