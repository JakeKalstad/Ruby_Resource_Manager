require File.dirname(__FILE__) + "/../../Enums/save_button"
require File.dirname(__FILE__) + "/../Models/save_model"
require 'rubygems'
require 'wx'

class Save_Dialog < Wx::Frame
  attr_accessor :success

   def initialize(initial_file, path)
      @model = Save_Model.new(initial_file)
      super(nil, :id => -1, :title => "Saving a new copy of #{initial_file}", :size => Wx::Size.new(600,150))
      @ids = Events::SaveButtons.new
      @panel = Wx::Panel.new(self)
      @text_box_path = Wx::TextCtrl.new(@panel, :id => 1, :value => File.dirname(path), :size => Wx::Size.new(550,20))
      create_buttons
      event_handlers
      sizer = setup_sizing
      @panel.set_sizer(sizer)
   end

   def create_buttons
     @done_button = Wx::Button.new(@panel, @ids.done, 'Done!')
     @cancel_button = Wx::Button.new(@panel, @ids.cancel, 'Cancel')
   end

   def event_handlers
      evt_button(@ids.done) {
                              @model.set_path(@text_box_path.value)
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
     @controls << @text_box_path
     @controls << @done_button
     @controls << @cancel_button
   end

   def add_sizer(control)
    @sizer.add(control, 0, 65, 0)
   end
end