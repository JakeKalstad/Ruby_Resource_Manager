require File.dirname(__FILE__) + "/../Model/manage_model"
require 'rubygems'
require 'wx'

class Manage_GUI < Wx::Frame

   def initialize
      super(nil,-1,'Manage .resx Files')
      initialize_components()
      @model = Manage_Events
      @model.populate_recent(@recent_menu)
      event_handlers()
   end


   def event_handlers
       evt_button(@ids.add) { @model.on_click(@ids.add) }
   end

   def initialize_components
     @ids = ButtonIds.new
     @component_ids = ComponentIds.new
     sizer = Wx::BoxSizer.new(Wx::VERTICAL)
     @map = Map.new.map
     @recent_menu = Wx::Choice.new(@panel, @component_ids.recent_choice)
     @panel = Wx::Panel.new(self)
     sizer.add(Wx::StaticText.new(@panel, @component_ids.recent_label, 'Recent Jobs'), 0, 65,0)
     sizer.add(@recent_menu, 0, 65,0)
     sizer.add(Wx::Button.new(@panel, @ids.add, 'Add File'), 0,0,1)
     @panel.set_sizer(sizer)
   end

end
