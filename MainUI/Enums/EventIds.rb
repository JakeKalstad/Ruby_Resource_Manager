module Events  
  class EventIds
     attr_accessor :help_id, :about_id, :exit_id, :translate_id, :manage_id
        def initialize
          @help_id = 1000
          @about_id = 1001
          @exit_id = 1002
          @translate_id = 1003
          @manage_id = 1004
        end
  end
end