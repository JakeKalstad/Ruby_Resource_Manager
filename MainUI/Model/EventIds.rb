module Events  
  class EventIds
     attr_accessor :help_id, :about_id, :exit_id
        def initialize
          @help_id = 1000
          @about_id = 1001
          @exit_id = 1002
        end
  end
end