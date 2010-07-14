class Invalid_Warning < Wx::Frame
  def Initialize(info, title)
    title = '' if title == nil
      super(nil, :id => -1, :title => title, :size => Wx::Size.new(200,150))    
  end

  def initialize_components
       @panel = Wx::Panel.new(self)
       @warning_label = Wx::StaticText.new(@panel, :id => 1, :label => 'The file you are trying to save is invalid, remember (.resx!)', :size => Wx::Size.new(250, 20))
       create_buttons
       @panel.set_sizer(setup_sizing)
  end

   def create_buttons
     @fixit_button = Wx::Button.new(@panel, 2, 'Resolve it!')
     @exit_button = Wx::Button.new(@panel, 3, 'Forget it!')
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
     @controls << @exit_button
   end

   def add_sizer(control)
    @sizer.add(control, 25, 65, 0)
   end
end