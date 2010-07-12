require File.dirname(__FILE__) + "/../Enums/save_button"

class Save_Events
  def click(id)
    ids = Events::SaveButtons.new
    (id == ids.done) ? exit_value = done_click : exit_value = cancel_click
    return exit_value
  end

  def done_click
      return true;
  end

  def cancel_click
      return false;  
  end
end