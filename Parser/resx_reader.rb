class Resx_Reader
  def initialize(file_name)
    file = File.open("file_name", "r")
    lines = file.readlines
  end
end