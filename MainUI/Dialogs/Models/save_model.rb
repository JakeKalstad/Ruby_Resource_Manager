require File.dirname(__FILE__) + "/../../Enums/save_button"
require File.dirname(__FILE__) + "/../View/overwrite_warning"
require File.dirname(__FILE__) + "/../View/invalid_warning"

class Save_Model

  def initialize
    set_path_map
  end

  def set_path(path)
    @path = path
    @map.fetch(valid_path).call
  end

  def valid_path
     @valid = valid?
     @exists = File.exists?(@path)
      if !@valid
        @path = @path + '.resx' if !@path.include? '.resx'
      end
        return :existent if @exists
        return :valid if valid?
        return :invalid
  end

  def valid?
    return false if @path == nil
    return @path[/([a-zA-Z]:(\\w+)*\\[a-zA-Z0_9]+)?.resx/] != nil
  end

  def show_warning
     dialog = OverWrite_Dialog.new
     dialog.show
     is_valid if dialog.can_overwrite
  end

  def is_valid

  end

  def invalid
      Invalid_Warning.new(@path + ' is invalid!', 'Invalid file path')
  end

  def set_path_map
    @map = Hash.new
    @map[:existent] = proc { show_warning }
    @map[:valid ] = proc { is_valid }
    @map[:invalid ] = proc { invalid }
  end
end