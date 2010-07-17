require 'rubygems'
require 'wx'

class Invalid_Warning < Wx::Frame
  def initialize(info, title)
    @info = info
    title = "" if title.nil?
    super(nil, :id => -2, :title => title, :size => Wx::Size.new(300,150))
    initialize_components
    button_events
  end
 private
  def initialize_components
    @panel = Wx::Panel.new(self)
    @warning_label = Wx::StaticText.new(@panel, :id => 1, :label => @info, :size => Wx::Size.new(150, 20))
    create_buttons
    @panel.set_sizer(setup_sizing)
  end

  def create_buttons
    @fixit_button = Wx::Button.new(@panel, 2, 'Resolve it!')
  end

  def button_events
    evt_button(2) { self.hide }
  end

  def setup_sizing
    stuff_controls
    @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
    @controls.each_index { |i| add_sizer(@controls[i]) }
    return @sizer
   end

   def stuff_controls
    @controls = Array.new(3)
    @controls << @warning_label
    @controls << @fixit_button
   end

   def add_sizer(control)
    @sizer.add(control, 25, 65, 0)
   end
end