require File.dirname(__FILE__) + "/../Enums/manage_buttons"
class Map
   attr_accessor :map

     def initialize(events)
        ids = ButtonIds.new
        @map = Hash.new
        @map[ids.add] = proc { events.add_file }
     end
end