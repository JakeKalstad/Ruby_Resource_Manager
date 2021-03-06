require File.dirname(__FILE__) + "/../Model/main_model"
require File.dirname(__FILE__) + "/../Event_Maps/event_map"
require File.dirname(__FILE__) + "/../Enums/EventIds"
require 'rubygems'
require 'wx'

include Events

class MainForm < Wx::App
      def on_init()         
        wire_events()
        @frame = Wx::Frame.new(nil, :id => -1, :title => 'Resource Manager')
        menu_bar = create_menu(@event_ids)
        @frame.set_menu_bar( menu_bar )
        @frame.set_client_size( Wx::Size.new(400,500) )
        menu_events
        Wx::Panel.new(@frame)
        @frame.show()
      end
    private
      def append_menu_dialogs
        menu_dialogs = Wx::Menu.new()
        menu_dialogs.append(@event_ids.manage_id, "&Manage!\t", '')
        menu_dialogs.append(@event_ids.help_id, "&Help!\t", '')
        menu_dialogs.append(@event_ids.about_id, "&About!\t", '')
        menu_dialogs.append(@event_ids.exit_id, "&Exit!\t", '')
        return menu_dialogs
      end

      def menu_events
        @frame.evt_menu(@event_ids.help_id) { on_dialog(@event_ids.help_id) }
        @frame.evt_menu(@event_ids.about_id) { on_dialog(@event_ids.about_id) }
        @frame.evt_menu(@event_ids.exit_id) { on_dialog(@event_ids.exit_id) }
        @frame.evt_menu(@event_ids.manage_id) { on_dialog(@event_ids.manage_id) }
      end



      def on_dialog(event)
        dialog_action = @events.epic_map.fetch(event)
        dialog_action.call
      end

      def wire_events
        @event_ids = Events::EventIds.new
        @events = Main_Events.new
        @events.create_map
      end

      def create_menu(ids)
        menu_dialogs = append_menu_dialogs
        menu_bar  = Wx::MenuBar.new
        menu_bar.append(menu_dialogs, "&Menu!")
        return menu_bar
      end
end

