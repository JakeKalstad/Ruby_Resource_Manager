require File.dirname(__FILE__) + "/../Model/manage_model"
require File.dirname(__FILE__) + "/../Enums/manage_buttons"
require File.dirname(__FILE__) + "/../Enums/manage_components"
require File.dirname(__FILE__) + "/../Event_Maps/manage_events"
require 'rubygems'
require 'wx'

class Manage_GUI < Wx::Frame
   def initialize
      super(nil, :id => -1, :title => 'Manage .resx Files', :size => Wx::Size.new(650,450),  :style => (Wx::DEFAULT_FRAME_STYLE | (Wx::RESIZE_BORDER|Wx::RESIZE_BOX|Wx::MAXIMIZE_BOX)))
      @model = Events::Manage_Events.new
      initialize_components
      event_handlers
   end

   def initialize_components
     @ids = ButtonIds.new
     @component_ids = ComponentIds.new

     @map = Map.new(@model).map
     @panel = Wx::Panel.new(self)
     
     create_recent_menu()
     @model.populate_recent(@recent_menu)
     create_buttons()
     setup_grid
     sizer = setup_sizing
     @panel.set_sizer(sizer)
   end
 private
   def event_handlers
     evt_button(@ids.add) {
                              @model.on_click(@ids.add)
                              @recent_menu.clear
                              @model.populate_recent(@recent_menu)
                              @model.populate_grid(@grid)
                            }
     evt_choice(@component_ids.recent_choice) {
                                                  @model.populate_grid(@grid)
                                                  set_size(get_size+1)
                                               }
     evt_button(@ids.delete)  {
                                 @model.remove_file(@recent_menu)
                                 @recent_menu.clear
                                 @model.populate_recent(@recent_menu)
                                 @model.populate_grid(@grid)
                              }

     evt_close() { self.show(false) }

     evt_button(@ids.save)  { @model.save_file(@recent_menu, @grid.get_table)}
   end

   def setup_grid
     @grid = Wx::Grid.new(@panel, @component_ids.grid_id, :size => Wx::Size.new(625,275))
     @grid.create_grid(5, 2)
     @grid.set_col_size( 0, 255 )
     @grid.set_col_size( 1, 255 )
     @grid.set_col_label_value(0, 'name')
     @grid.set_col_label_value(1, 'value')
     @grid.set_row_label_alignment(Wx::ALIGN_CENTRE, Wx::ALIGN_CENTRE)
   end

   def create_buttons
     @add_button = Wx::Button.new(@panel, @ids.add, 'Add File')
     @delete_button = Wx::Button.new(@panel, @ids.delete, 'Delete Recent')
     @save_button = Wx::Button.new(@panel, @ids.save, 'Save File')
   end

   def create_recent_menu
     @recent_menu = Wx::Choice.new(@panel, @component_ids.recent_choice)
     @recent_label =  Wx::StaticText.new(@panel, @component_ids.recent_label, 'Recent Jobs')
   end

   def setup_sizing
       stuff_controls
       @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
       @controls.each_index { |i| add_sizer(@controls[i]) }
     return @sizer
   end

   def stuff_controls
     @controls = Array.new(6)
     @controls << @recent_label
     @controls << @recent_menu
     @controls << @save_button
     @controls << @add_button
     @controls << @delete_button     
     @controls << @grid
   end

   def add_sizer(control)
    @sizer.add(control, 0, 65, 0)
   end
end
