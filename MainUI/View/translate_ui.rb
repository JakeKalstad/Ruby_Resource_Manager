require 'rubygems'
require 'wx'

class Translate_GUI < Wx::Frame
   def initialize
      super(nil, :id => -1, :title => 'Translate .resx Files')
      @panel = Wx::Panel.new(self)
   end
end