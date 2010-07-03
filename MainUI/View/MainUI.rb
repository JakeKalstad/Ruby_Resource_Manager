require 'EventIds'
require 'event_map'
require 'event_commander'
require 'rubygems'
require 'wx'


class MainForm < Wx::App

     def on_init()

        ids = Events::EventIds.new

        frame = Wx::Frame.new(nil, -1, 'Resource Manager')

        menu_dialogs = Wx::Menu.new()
        menu_dialogs.append(ids.help_id, "&Help!\t", 'I need somebody')
        menu_dialogs.append(ids.about_id, "&About!\t", '')

        menu_bar  = Wx::MenuBar.new()
        menu_bar.append(menu_dialogs, "&Menu!")

        frame.set_menu_bar( menu_bar )
        frame.set_client_size( Wx::Size.new(400,500) )

        frame.evt_menu(ids.help_id) {  on_dialog(ids.help_id) }
        frame.evt_menu(ids.about_id) { on_dialog(ids.about_id) }

        panel = Wx::Panel.new(frame)
        frame.show()
     end

    DIALOG_OPTIONS = Wx::NO_DEFAULT

    def on_dialog(event)
        help_proc = proc { help_dialog }
        about_proc = proc { about_dialog }

        epic_map = Mapping::EventMap.new(help_proc, about_proc).map

        dialog_action = epic_map.fetch(event)
        dialog_action.call
    end

     def help_dialog
         confirm = Wx::MessageDialog.new(nil, "Soo0o0o0on to come",
                                         "HELP", DIALOG_OPTIONS)
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
end

MainForm.new.main_loop