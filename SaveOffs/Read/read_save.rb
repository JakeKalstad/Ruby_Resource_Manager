class Read

  @@save_location = 'saved_jobs.wtf'
    def self.receive_file_contents
        if !File.exist?(@@save_location)
          File.new(@@save_location, 'w')
        end

        file = File.open(@@save_location, 'r')
        index = 0
        @contents = Array.new
        file.each {|line| @contents[index] = line; index+=1 }
        return @contents
    end
end