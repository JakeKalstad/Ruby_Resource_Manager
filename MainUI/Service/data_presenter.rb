require File.dirname(__FILE__) + '/../../SaveOffs/Read/read_save'
require File.dirname(__FILE__) + '/../../Parser/node_manufacturer'

class ResxPresenter
   def retrieve_from_choice(choice_selection)
     @values = Array.new
     return if choice_selection == ""
     resources = LiteQuery.new.get_resource_from_current_choice(choice_selection)
     resources.each_index { |i|
                                 @display_item = Struct.new(:name, :value).new
                                 @display_item.name = Table_Extension.get_resource_name(resources,i)
                                 @display_item.value = Table_Extension.get_resource_value(resources,i)
                                 @values << @display_item
                          }
     return @values
   end
end