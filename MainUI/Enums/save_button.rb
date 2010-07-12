module Events
  class SaveButtons
    attr_accessor :done, :cancel
      def initialize
      @done = 4000
      @cancel = 4001
      end
  end
end