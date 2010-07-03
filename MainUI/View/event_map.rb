require 'EventIds'


module Mapping
  class EventMap
     attr_accessor :map

      def initialize(about_ptr, help_ptr)

      ids = Events::EventIds.new
      @map = Hash.new
      @map[ids.about_id] = about_ptr
      @map[ids.help_id] =  help_ptr
      end
  end
end