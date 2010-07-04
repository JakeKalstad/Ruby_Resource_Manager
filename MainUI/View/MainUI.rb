require File.dirname(__FILE__) + "/../Model/main_events"
require File.dirname(__FILE__) + "/../Model/EventIds"
require File.dirname(__FILE__) + "/../Model/event_map"
require 'rubygems'
require 'wx'

include Events

class MainForm < Wx::App


      def on_init()
        wire_events()
        ids = Events::EventIds.new

        frame = Wx::Frame.new(nil, -1, 'Resource Manager')
        
        menu_dialogs = append_menu_dialogs(ids)
        menu_bar  = Wx::MenuBar.new()
        menu_bar.append(menu_dialogs, "&Menu!")

        frame.set_menu_bar( menu_bar )
        frame.set_client_size( Wx::Size.new(400,500) )

        menu_events(frame, ids)

        panel = Wx::Panel.new(frame)
        frame.show()
      end

      def menu_events(frame, ids)
         frame.evt_menu(ids.help_id) { on_dialog(ids.help_id) }
         frame.evt_menu(ids.about_id) { on_dialog(ids.about_id) }
         frame.evt_menu(ids.exit_id) { on_dialog(ids.exit_id) }
      end

      def append_menu_dialogs(ids)
             menu_dialogs = Wx::Menu.new()
             menu_dialogs.append(ids.help_id, "&Help!\t", 'I need somebody')
             menu_dialogs.append(ids.about_id, "&About!\t", '')
             menu_dialogs.append(ids.exit_id, "&Exit!\t", '')
           return menu_dialogs
      end

      def on_dialog(event)
          dialog_action = @events.epic_map.fetch(event)
          dialog_action.call
      end

      def wire_events
          @events = Main_Events.new
          @events.create_map
      end

end

MainForm.new.main_loop