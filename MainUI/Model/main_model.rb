require File.dirname(__FILE__) + '/../view/manage_ui'
require File.dirname(__FILE__) + '/../Event_Maps/event_map'
require 'rubygems'
require 'wx'

module Events
  class Main_Events
  attr_accessor :epic_map
  DIALOG_OPTIONS = Wx::NO_DEFAULT

    def create_map
         help_proc = proc { help_dialog }
         about_proc = proc { about_dialog }
         exit_proc = proc { exit }
         manage_proc = proc { manage_click }
         @epic_map = Mapping::EventMap.new(about_proc, help_proc, exit_proc, manage_proc).map
     end
#                     I should almost put this in a resource file... :D
  $help_message = "Enter the manager form and add a .resx file from the file dialog.\n
                   Open a second manager pane and choose the added file from the recent menus.\n
                   Using a form for reference/soft-copy and a second form to make edits, \n
                   choose or provide the resources culture (fr-FR, en-GB, etc..) and hit save!\n"
  private
     def help_dialog
         confirm = Wx::MessageDialog.new(nil, $help_message, "HELP", DIALOG_OPTIONS)
         case confirm.show_modal()
           when Wx::ID_OK
             puts "OK"
         end
     end

     def about_dialog
         confirm = Wx::MessageDialog.new(nil, "A resource management tool to help make localization\n\t the easy part!",
                                         "About!", DIALOG_OPTIONS)
          case confirm.show_modal()
           when Wx::ID_OK
             puts "OK"
          end
     end

     def exit
         self.exit
     end

     def manage_click
       Manage_GUI.new.show
     end
  end
end