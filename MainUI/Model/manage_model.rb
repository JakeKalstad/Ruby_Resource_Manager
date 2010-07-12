require File.dirname(__FILE__) + "/../Dialogs/file_dialog"
require File.dirname(__FILE__) + "/../../SaveOffs/Read/read_save"
require File.dirname(__FILE__) + "/../../SaveOffs/Write/write_save"
require File.dirname(__FILE__) + "/data_presenter"
require File.dirname(__FILE__) + "/../Event_Maps/manage_events"
require File.dirname(__FILE__) + "../../../SQLite/lite_query"
module Events
  class Manage_Events

     def initialize
        @presenter = ResxPresenter.new
        @current_set = 1          # SHOULD BE DECIDED VIA CURRENT SELECTION
     end

     def add_file
       dialog = File_Dialog.new(nil, 'Choose a .resx file!', 'RESX File (*.resx)|*.resx|')
       result = dialog.show_modal
       if result == Wx::ID_OK
        saver = Save.new(dialog.get_path(), @current_set)
       end
     end

     def remove_file(choice_box)
       @query = LiteQuery.new
       @query.remove_save_by_name(choice_box.get_string_selection)
     end

     def save_file(choice_box, grid_contents)

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

     def save_file()

     end

     def populate_grid(grid)
          @main_grid = grid
          @main_grid.table.clear
          @main_grid.refresh
          choice = @choice.get_string_selection
          content = @presenter.retrieve_from_choice(choice)
          return if content == nil
          content.each_index do |index|
          @main_grid.set_cell_value(index, 1, content[index].value.strip)
          @main_grid.set_cell_value(index, 0, content[index].name)
        end
     end
  end
end