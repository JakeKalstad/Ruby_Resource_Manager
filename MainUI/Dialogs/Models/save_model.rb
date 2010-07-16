require File.dirname(__FILE__) + "/../../Enums/save_button"
require File.dirname(__FILE__) + "/../View/overwrite_warning"
require File.dirname(__FILE__) + "/../View/invalid_warning"
require File.dirname(__FILE__) + "/../../../SaveOffs/Write/resx_creator"
require File.dirname(__FILE__) + "/../../../SaveOffs/Write/write_save"

class Save_Model
      attr_accessor :overwrite
  def initialize(origin)
    @origin = origin
    set_path_map
    @overwrite = true
  end

  def set_path(path)
     @path = path
     @map.fetch(valid_path).call
  end

  def valid_path
     validation @path
     @exists = File.exists?(@path)
      if @invalid
        @path = @path + '.resx' if !@path.include? '.resx'
      end
     validation(@path)
     return :existent if @exists
     return :valid if !@invalid
     return :invalid
  end

  def validation(path)
     return false if path == nil
     @invalid = path[/([a-zA-Z]:(\\w+)*\\[a-zA-Z0_9]+)?.resx/].nil?
  end

  def show_warning
     dialog = OverWrite_Dialog.new self
     dialog.show
  end

  def is_valid
     return if not @overwrite || @origin.nil?
     Resx_Creator.new(@origin, @path)
  end

  def invalid
     dialog = Invalid_Warning.new( @path + ' is invalid!', 'Invalid file path')
     dialog.show
  end

  def set_path_map
     @map = Hash.new
     @map[:existent] = proc { show_warning }
     @map[:valid ] = proc { is_valid }
     @map[:invalid ] = proc { invalid }
  end
end