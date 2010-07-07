require File.dirname(__FILE__) + "/../Dialogs/file_dialog"
require File.dirname(__FILE__) + "/../../SaveOffs/Read/read_save"
require File.dirname(__FILE__) + "/../../SaveOffs/Write/write_save"
require File.dirname(__FILE__) + "/data_presenter"

class Manage_Events

   def initialize
      @presenter = ResxPresenter.new
   end

   def add_file
     dialog = File_Dialog.new(nil, 'Choose a .resx file!', 'RESX File (*.resx)|*.resx|')
     result = dialog.show_modal
     if result == Wx::ID_OK
      saver = Save.new(dialog.get_path())
     end
   end

   def on_click(id)
       @map = Map.new.map
       action = @map.fetch(id)
       action.call
   end

   def populate_recent(choice_box)
     @choice = choice_box
     contents = Read.new.receive_file_contents
     contents.each_index { |index|  @choice.append(contents[index].split("\\").last) }
   end

   def populate_grid(grid)
        @main_grid = grid
        @main_grid.table.clear
        @main_grid.refresh
        choice = @choice.get_string_selection
        content = @presenter.retrieve_contents_from_choice(choice)
        content.each_index do |index|
        @main_grid.set_cell_value(0, index, content[index].value.strip)
        @main_grid.set_cell_value(1, index, content[index].name)
      end
   end
end

class ButtonIds
  attr_accessor :add, :save, :delete
    def initialize
      @add = 2000
      @save = 2001
      @delete = 2002
    end
end

class ComponentIds
  attr_accessor :recent_choice, :recent_label, :grid_id, :delete_button
    def initialize
      @recent_choice = 3000
      @recent_label = 3001
      @grid_id = 3002
    end
end

class Map
   attr_accessor :map

     def initialize()
        events = Manage_Events.new
        ids = ButtonIds.new
        comp_ids = ComponentIds.new
        @map = Hash.new
        @map[ids.add] = proc { events.add_file }
     end
end
