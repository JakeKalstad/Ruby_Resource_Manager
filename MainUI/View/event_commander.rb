require 'EventIds'
require 'rubygems'
require 'wx'

class EventCommander
  include Wx


    attr_accessor :help_command, :about_command
  def setup
    ids = Events::EventIds.new
    @@help_command = CommandEvent.new(0,  ids.help_id)
    @@about_command = CommandEvent.new(1,  ids.about_id)
  end
end