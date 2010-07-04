require File.dirname(__FILE__) + "/../Dialogs/file_dialog"
require 'rubygems'
require 'wx'

class Manage_GUI < Wx::Frame

   def initialize
      @ids = ButtonIds.new

      super(nil,-1,'Manage .resx Files')
      @panel = Wx::Panel.new(self)
      @button = Wx::Button.new(@panel, @ids.add, 'Add File')

      evt_button(@ids.add) { on_click(@ids.add) }
   end
   
   def on_click(id)
       File_Dialog.new(self, 'Choose a .resx file!', '.net Resources(.resx)').show_modal
   end
end

class ButtonIds
  attr_accessor :add
  def initialize
   @add = 2000
  end
end