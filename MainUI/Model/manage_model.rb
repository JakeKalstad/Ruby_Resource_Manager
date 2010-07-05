require File.dirname(__FILE__) + "/../Dialogs/file_dialog"
require File.dirname(__FILE__) + "/../../SaveOffs/Read/read_save"
require File.dirname(__FILE__) + "/../../SaveOffs/Write/write_save"
class Manage_Events
 
   def add_file
     dialog = File_Dialog.new(nil, 'Choose a .resx file!', 'RESX File (*.resx)|*.resx|')
     result = dialog.show_modal
     if result == Wx::ID_OK
      saver = Save.new(dialog.get_path())
     end
   end

   def on_click(id)
      @map = Map.new.map
      puts id
       action = @map.fetch(id)
       action.call
   end

   def populate_recent(choice_box)
     contents = Read.new.receive_file_contents
     contents.each_index { |index|  choice_box.append(contents[index].split("\\").last) }
   end

end

class ButtonIds
  attr_accessor :add
    def initialize
      @add = 2000
    end
end

class ComponentIds
  attr_accessor :recent_choice, :recent_label
    def initialize
      @recent_choice = 3000
      @recent_label = 3001
    end
end

class Map
   attr_accessor :map

     def initialize()
        events = Manage_Events.new
        ids = ButtonIds.new
        @map = Hash.new
        @map[ids.add] = proc { events.add_file }
     end
end
