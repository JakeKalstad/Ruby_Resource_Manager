require 'rubygems'
require 'wx'

class Translate_GUI < Wx::Frame

  def initialize
      super(nil,-1,'Translate .resx Files')
      @panel = Wx::Panel.new(self)
   end

   def on_init

   end
  
end