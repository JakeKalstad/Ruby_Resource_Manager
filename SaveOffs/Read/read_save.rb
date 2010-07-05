
class Read
    def self.receive_file_contents(file_path) 
        file = File.open(file_path)
        index = 0
        @contents = Array.new
        file.each {|line| @contents[index] = line; index+=1 }
        return @contents
    end
end