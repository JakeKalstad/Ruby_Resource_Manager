module Events  
  class EventIds
     attr_accessor :help_id, :about_id
        def initialize
          @help_id = 1000
          @about_id = 1001
        end
  end
end