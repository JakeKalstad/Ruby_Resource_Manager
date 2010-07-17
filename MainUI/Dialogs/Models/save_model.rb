require File.dirname(__FILE__) + "/../../Enums/save_button"
require File.dirname(__FILE__) + "/../View/overwrite_warning"
require File.dirname(__FILE__) + "/../View/invalid_warning"
require File.dirname(__FILE__) + "/../../../SaveOffs/Write/resx_creator"
require File.dirname(__FILE__) + "/../../../SaveOffs/Write/write_save"
require File.dirname(__FILE__) + "/../../../SQLite/lite_query"

class Save_Model
 attr_accessor :overwrite
    def initialize(origin, table_base)
      @table_base = table_base
      @origin = origin
      set_path_map
      @overwrite = true
      @query = LiteQuery.new
    end

    def set_path(path)
       @path = path
       @map.fetch(valid_path).call
    end
   private
    def valid_path
       validation @path
       @exists = File.exists?(@path)
        if @invalid
          @path = @path + '.resx' if !@path.include? '.resx'
        end
       validation(@path)
       return :existent if @exists
       return :valid if !@invalid
       return :invalid
    end

    def validation(path)
       return false if path == nil
       @invalid = path[/([a-zA-Z]:(\\w+)*\\[a-zA-Z0_9]+)?.resx/].nil?
    end

    def show_warning
       dialog = OverWrite_Dialog.new self
       dialog.show
    end

    def is_valid
       return if not @overwrite || @origin.nil?
       save_changes
       Resx_Creator.new(@origin, @path)
    end

    def invalid
       dialog = Invalid_Warning.new( @path + ' is invalid!', 'Invalid file path')
       dialog.show
    end

    def save_changes
       retrieve_grid_content(@table_base)
       @query.insert_save(@path, 1)
       @key = @query.get_save_from_path(@path)
       @values.each_index {|i| @query.insert_resource_values(@key, @names[i], @values[i])}
    end

    def retrieve_grid_content(table_base)
       row_count = table_base.get_number_rows
       @names = Array.new
       @values = Array.new
         (1..row_count).each do |i|
           @names <<  table_base.get_value(i-1, 0) if not table_base.get_value(i-1, 0) == ""
           @values << table_base.get_value(i-1, 1) if not table_base.get_value(i-1, 1) == ""
         end
     end

     def set_path_map
       @map = Hash.new
       @map[:existent] = proc { show_warning }
       @map[:valid ] = proc { is_valid }
       @map[:invalid ] = proc { invalid }
     end
end