module Events
  class SaveButtons
    attr_accessor :done, :cancel, :iso_code_drop
      def initialize
      @done = 4000
      @cancel = 4001
      @iso_code_drop = 4002
      end
  end
end