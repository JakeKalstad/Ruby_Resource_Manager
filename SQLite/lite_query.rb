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
           find_highest_resource_id
          save_id = @highest if save_id == nil
          @data_base.execute("update save set active_save = 1 where resource_key == ?", @highest)
          @data_base.execute("insert into resource_pairs values (?, ?, ?, ?, ?)", @highest, save_id, 1, name, value)   
     end

     def update_deleted_save(key)
       @data_base.execute("update save set active_save = 1 where save_key == ?", key)
     end

     def insert_save(file, set)
          previous_saves = get_saves
          previous_saves.each_index { |i|if previous_saves[i][3].include? file
                                           @existent = true
                                           update_deleted_save(previous_saves[i][0])
          end
                                     }
         return if @existent
         @data_base.execute("insert into save values (?,?,?,?,?)", 1, @highest, set, file, 0)
     end

     def remove_save_by_name(save_file)
         file = save_file.split(' ')[0]
         saves = @data_base.execute("select * from save")
         saves.each_index { |i|  if Table_Extension.get_save_display_string(saves, i).include? file
                                                @key = Table_Extension.get_save_resource_key(saves, i)
                                  end
                            }
         remove_save_by_resource_key(@key)
     end

     def remove_save_by_resource_key(resource_key)
         @data_base.execute("update save set active_save = 0 where resource_key == ?", resource_key)
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
       saves.each_index { |i| if (saves[i][3].include?(save) && saves[i][4])
                                @set_key = saves[i][2] 
                              end
                        }
     end

     def resource_exists(value)
          resources = get_all_resources
          return if resources == nil
          exists = false
       resources.each_index { |i|  return if resources[i][4] == nil
                               exists = true if (resources[i][4].include? value)
                             }
       return exists
     end

     def get_saves
       return @data_base.execute('select * from save')
     end

     def get_unattached_save
      return @data_base.execute("SELECT save_key FROM save where active_save != 1")
     end

     def get_resource_from_current_choice(recent_choice)
        @key = save_set(recent_choice)[2]
        @resources = get_resource_set
        return @resources
     end

    def find_highest_resource_id
      @highest = 0
      @rows = get_all_resources
      @rows.each_index { |i| @highest = @rows[i][0] if @rows[i][4] && @rows[i][0] > @highest}
      @highest = 1 if @highest == 0
    end
end
