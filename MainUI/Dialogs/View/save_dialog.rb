require File.dirname(__FILE__) + "/../../Enums/save_button"
require File.dirname(__FILE__) + "/../Models/save_model"
require 'rubygems'
require 'wx'

class Save_Dialog < Wx::Frame
 attr_accessor :success
   def initialize(initial_file, path, current_table_base)
     @model = Save_Model.new(initial_file, current_table_base, path)
     super(nil, :id => -1, :title => "Saving a new copy of #{initial_file}", :size => Wx::Size.new(600,150))
     @ids = Events::SaveButtons.new
     @panel = Wx::Panel.new(self)
     create_locale_menu
     @model.populate_locale_codes(@locale_menu)
     create_buttons
     event_handlers
     sizer = setup_sizing
     @panel.set_sizer(sizer)
   end
 
 private
   def create_buttons
     @done_button = Wx::Button.new(@panel, @ids.done, 'Done!')
     @cancel_button = Wx::Button.new(@panel, @ids.cancel, 'Cancel')
   end

   def create_locale_menu
     @locale_menu = Wx::Choice.new(@panel, @ids.iso_code_drop)
     @locale_label =  Wx::StaticText.new(@panel, 45, 'Locale Codes')
   end

   def event_handlers
      evt_button(@ids.done) {
                              @model.set_locale(@locale_menu.get_string_selection)
                              self.hide
                            }
      evt_button(@ids.cancel) { self.hide }
   end

   def setup_sizing
      stuff_controls
      @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
      @controls.each_index { |i| add_sizer(@controls[i]) }
      return @sizer
   end

   def stuff_controls
      @controls = Array.new(3)
      @controls << @locale_label
      @controls << @locale_menu
      @controls << @done_button
      @controls << @cancel_button
   end

   def add_sizer(control)
     @sizer.add(control, 0, 65, 0)
   end
end