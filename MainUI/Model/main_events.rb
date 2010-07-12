require File.dirname(__FILE__) + '/../view/manage_ui'
require File.dirname(__FILE__) + '/../view/translate_ui'
require File.dirname(__FILE__) + '/../Event_Maps/event_map'
require 'rubygems'
require 'wx'

module Events
  class Main_Events
    
    attr_accessor :epic_map
    DIALOG_OPTIONS = Wx::NO_DEFAULT

     def help_dialog
         confirm = Wx::MessageDialog.new(nil, "Soo0o0o0on to come", "HELP", DIALOG_OPTIONS)
         case confirm.show_modal()
           when Wx::ID_OK
             puts "OK"
         end
     end

     def about_dialog
         confirm = Wx::MessageDialog.new(nil, "Prospect of a resource manager for .net .resx files, translations, creation, and editing for a project management perspective!",
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

      def translate_click
       Translate_GUI.new.show
     end

     def create_map
       help_proc = proc { help_dialog }
       about_proc = proc { about_dialog }
       exit_proc = proc { exit }
       manage_proc = proc { manage_click }
       translate_proc = proc { translate_click }
       @epic_map = Mapping::EventMap.new(about_proc, help_proc, exit_proc, manage_proc, translate_proc).map
     end
  end
end