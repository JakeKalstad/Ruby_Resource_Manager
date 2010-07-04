require 'rubygems'
require 'wx'

class File_Dialog < Wx::FileDialog
   def initialize(parent, message, file_wild_card)
     super(parent, message, '', '', file_wild_card)
   end
end