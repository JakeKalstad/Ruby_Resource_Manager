require File.dirname(__FILE__) + "/../Dialogs/file_dialog"
class Manage_Events
     def add_file
     dialog = File_Dialog.new(nil, 'Choose a .resx file!', 'RESX File (*.resx)|*.resx|')
     result = dialog.show_modal
     if result == Wx::ID_OK
       puts "User selected file: #{dialog.get_path()}"
     end
   end
end

class ButtonIds
  attr_accessor :add
  def initialize
   @add = 2000
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
