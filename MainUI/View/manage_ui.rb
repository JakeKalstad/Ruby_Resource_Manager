require File.dirname(__FILE__) + "/../Model/manage_model"
require 'rubygems'
require 'wx'

class Manage_GUI < Wx::Frame

   def initialize
      super(nil,-1,'Manage .resx Files')
      @model = Manage_Events.new
      initialize_components()
      event_handlers()
   end

   def initialize_components
     @ids = ButtonIds.new
     @component_ids = ComponentIds.new

     @map = Map.new.map
     @panel = Wx::Panel.new(self)
     @recent_menu = Wx::Choice.new(@panel, @component_ids.recent_choice)
     @model.populate_recent(@recent_menu)
     grid = setup_grid()
     recent_label =  Wx::StaticText.new(@panel, @component_ids.recent_label, 'Recent Jobs')
     add_button = Wx::Button.new(@panel, @ids.add, 'Add File')
     
     sizer = setup_sizing(add_button, grid, recent_label)
     @panel.set_sizer(sizer)
   end
   def event_handlers
       puts @ids.add
       evt_button(@ids.add) {
                              @model.on_click(@ids.add)
                              @recent_menu.clear
                              @model.populate_recent(@recent_menu)
                            }
   end

   def setup_grid
     grid = Wx::Grid.new(@panel, @component_ids.grid_id)
     grid.create_grid(5, 2)
     grid.set_col_label_value(0, 'name')
     grid.set_col_label_value(1, 'value')
     return grid
   end

   def setup_sizing(add_button, grid, recent_label)
     sizer = Wx::BoxSizer.new(Wx::VERTICAL)
     sizer.add(recent_label, 0, 65, 0)
     sizer.add(@recent_menu, 0, 65, 0)
     sizer.add(add_button, 0, 0, 1)
     sizer.add(grid)
     return sizer
   end
end
