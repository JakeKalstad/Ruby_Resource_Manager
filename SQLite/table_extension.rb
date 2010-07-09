class Table_Extension
   def self.get_resource_name(resource, index)
     return resource[index][3]
   end

  def self.get_resource_value(resource, index)
     return resource[index][4]
  end

  def self.get_resource_tuple_name(tuple)
    return tuple[0]
  end

  def self.get_resource_tuple_value(tuple)
    return tuple[1]
  end

  def self.get_save_display_string(save, index)
    return save[index][3].split("\\")
  end
end