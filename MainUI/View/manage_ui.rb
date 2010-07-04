require File.dirname(__FILE__) + "/../Model/manage_events"
require 'rubygems'
require 'wx'

class Manage_GUI < Wx::Frame

   def initialize
      @ids = ButtonIds.new
      @map = Map.new.map
      super(nil,-1,'Manage .resx Files')
      @panel = Wx::Panel.new(self)
      @button = Wx::Button.new(@panel, @ids.add, 'Add File')

      evt_button(@ids.add) { on_click(@ids.add) }
   end

   def on_click(id)
       action = @map.fetch(id)
       action.call
   end
end
