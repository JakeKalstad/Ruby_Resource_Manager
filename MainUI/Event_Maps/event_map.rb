require File.dirname(__FILE__) + "/../Enums/EventIds"

module Mapping
  class EventMap
   attr_accessor :map
      def initialize(about_ptr, help_ptr, exit_ptr, manage_ptr)
        ids = Events::EventIds.new
        @map = Hash.new
        @map[ids.about_id] = about_ptr
        @map[ids.help_id] =  help_ptr
        @map[ids.exit_id] = exit_ptr
        @map[ids.manage_id] =  manage_ptr
      end
  end
end