require File.dirname(__FILE__) + "/../Model/manage_model"
require File.dirname(__FILE__) + "/../Model/grid_helper/grid_help"
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
     @recent_label =  Wx::StaticText.new(@panel, @component_ids.recent_label, 'Recent Jobs')
     @add_button = Wx::Button.new(@panel, @ids.add, 'Add File')
     @save_button = Wx::Button.new(@panel, @ids.save, 'Save File')
     setup_grid
     sizer = setup_sizing
     @panel.set_sizer(sizer)
   end

   def event_handlers
       evt_button(@ids.add) {
                              @model.on_click(@ids.add)
                              @recent_menu.clear
                              @model.populate_recent(@recent_menu)
                            }
      evt_choice(@component_ids.recent_choice) { @model.populate_grid(@grid) }
      evt_choice(@component_ids.delete_button) { @model.delete_selection() }
   end

   def setup_grid
    @grid = Wx::Grid.new(@panel, @component_ids.grid_id)
    @grid.create_grid(5, 2)
    @grid.set_col_label_value(0, 'name')
    @grid.set_col_label_value(1, 'value')
   end



   def setup_sizing
       stuff_controls
       @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
       @controls.each_index { |i| add_sizer(@controls[i]) }
     return @sizer
   end

   def stuff_controls
     @controls = Array.new(4)
     @controls << @recent_label
     @controls << @recent_menu
     @controls << @save_button
     @controls << @add_button
     @controls << @grid
   end

   def add_sizer(control)
    @sizer.add(control, 0, 65, 0)
   end

end
