require File.dirname(__FILE__) + "/../../SaveOffs/Read/read_save"
require File.dirname(__FILE__) + "/../../SaveOffs/Write/write_save"
require File.dirname(__FILE__) + "/../Service/data_presenter"
require File.dirname(__FILE__) + "/../Event_Maps/manage_events"
require File.dirname(__FILE__) + "../../../SQLite/lite_query"
require File.dirname(__FILE__) + "/../Dialogs/View/save_dialog"
require File.dirname(__FILE__) + "/../Dialogs/View/file_dialog"

module Events
  class Manage_Events

     def initialize
        @query = LiteQuery.new
        @presenter = ResxPresenter.new
        @current_set = 1          # SHOULD BE DECIDED VIA CURRENT SELECTION
     end

     def add_file
       dialog = File_Dialog.new(nil, 'Choose a .resx file!', 'RESX File (*.resx)|*.resx|')
       result = dialog.show_modal
       if result == Wx::ID_OK
        Save.new(dialog.get_path(), @current_set)
       end
     end

     def remove_file(choice_box)
       choice = choice_box.get_string_selection
       return if choice == "" || choice == nil
       @query.remove_save_by_name(choice_box.get_string_selection)
     end

     def save_file(choice_box, grids_table_base)
           content = get_content
           previous_saves = LiteQuery.new.get_saves
           previous_saves.each_index { |i| @path = previous_saves[i][3] if previous_saves[i][3].include? choice_box.get_string_selection }
           @path = File.dirname(__FILE__) if @path == nil

           save_changes(grids_table_base)
           dialog = Save_Dialog.new(choice_box.get_string_selection, @path)
           dialog.show
           return if not dialog.success
           content.each_index { |i| @query.update_resource_values(content[i][0], content[i][3], content[i][4]) }
           ResxMaker.Create(dialog.Path)
     end

     def on_click(id)
         @map = Map.new(self).map
         action = @map.fetch(id)
         action.call
     end

     def populate_recent(choice_box)
         @choice = choice_box
         contents = Read.new.project_displayable_contents
         return if contents == nil
         contents.each_index { |index| @choice.append(contents[index]) }
     end

     def save_changes(grids_table_base)
         retrieve_grid_content(grids_table_base)
         @query.insert_save(@path, 1)
         @key = @query.get_unattached_save;
         @values.each_index {|i|@query.insert_resource_values_to_set(@key, 1, @names[i], @values[i])}
     end

     def retrieve_grid_content(table_base)
       row_count = table_base.get_number_rows
       @names = Array.new
       @values = Array.new
       (1..row_count).each do |i|
          @names << table_base.get_value(i, 1)
          @values << table_base.get_value(i, 2)
       end
     end

     def populate_grid(grid)
          refresh_grid(grid)
          content = get_content
          return if content == nil
          content.each_index do |index|
          set_grid_values(content, index)
        end
     end

     def set_grid_values(content, index)
         @main_grid.append_rows(1)
         return if (content[index].value == nil || content[index].name == nil)
         @main_grid.set_cell_value(index, 1, content[index].value.strip)
         @main_grid.set_cell_value(index, 0, content[index].name)
     end

     def refresh_grid(grid)
         @main_grid = grid
         @main_grid.table.clear
         @main_grid.refresh
     end

     def get_content
         choice = @choice.get_string_selection
         content = @presenter.retrieve_from_choice(choice)
         return content
     end
  end
end