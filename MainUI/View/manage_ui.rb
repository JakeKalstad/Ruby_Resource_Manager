require 'rubygems'
require 'wx'

class Manage_GUI < Wx::Frame

   def initialize
      super(nil,-1,'Manage .resx Files')
      @panel = Wx::Panel.new(self)
   end
  
   def on_init

   end
end

