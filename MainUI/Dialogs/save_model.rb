require File.dirname(__FILE__) + "/../Enums/save_button"
require File.dirname(__FILE__) + "/overwrite_warning"
require File.dirname(__FILE__) + "/invalid_warning"

class Save_Events
  def click(id)
    ids = Events::SaveButtons.new
    return (id == ids.done) ? true : false
  end
end

class Save_Model

  def initialize
    set_path_map
  end

  def set_path(path)
    @path = path
    @map.fetch(valid_path).call
  end

  def valid_path
    valid = @path.include? '.resx'
      if valid
        return 'existent' if File.exists?(@path)
        return 'valid'
      else return 'invalid'
    end
  end

  def show_warning
      OverWrite_Dialog.new.show
  end

  def is_valid

  end

  def invalid
      Invalid_Warning.new.show
  end

  def set_path_map
    @map = Hash.new
    @map['existent'] = proc { show_warning }
    @map['valid' ] =  proc  { is_valid }
    @map['invalid' ] = proc { invalid }
  end
end