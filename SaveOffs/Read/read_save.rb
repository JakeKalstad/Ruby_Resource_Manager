class Read

  def initialize
    @contents = Array.new
  end

  @@save_location = 'saved_jobs.wtf'
    def receive_file_contents
      if !File.exist?(@@save_location)
          File.new(@@save_location, 'w')
      end

        file = File.open(@@save_location, 'r')
        index = 0
        file.each { |line|
                    @contents[index] = line
                    index+=1
                  }
        file.close
        return @contents
    end
end