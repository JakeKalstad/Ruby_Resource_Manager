require 'rubygems'
require 'wx'

class Save_Dialog < Wx::Frame
   def initialize(initial_file)
      super(nil, :id => -1, :title => "Saving a new copy of #{initial_file}", :size => Wx::Size.new(300,300))
      @panel = Wx::Panel.new(self)
   end
end