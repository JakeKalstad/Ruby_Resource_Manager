require 'rubygems'
require 'wx'

class OverWrite_Dialog < Wx::Frame
  def initialize
    super(nil, :id => -1, :title => "!Warning!", :size => Wx::Size.new(350,250))
    initialize_components
  end

  def initialize_components
       @panel = Wx::Panel.new(self)
       @text_box_path = Wx::StaticText.new(@panel, :id => 1, :label => 'You are attempting to Overwrite an existing resource. Would you like to proceed (bad idea)', :size => Wx::Size.new(250, 20))
       create_buttons
       @panel.set_sizer(setup_sizing)
  end

   def create_buttons
     @ok_button = Wx::Button.new(@panel, 2, 'Overwrite it!')
     @cancel_button = Wx::Button.new(@panel, 3, 'NO! WAIT! DONT!')
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
     @controls << @ok_button
     @controls << @cancel_button
   end

   def add_sizer(control)
    @sizer.add(control, 25, 65, 0)
   end
end