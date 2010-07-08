require File.dirname(__FILE__) + '/../../SaveOffs/Read/read_save'
require File.dirname(__FILE__) + '/../../Parser/node_manufacturer'

class ResxPresenter

   def retrieve_from_choice(choice_selection)
     @values = Array.new
     resources = LiteQuery.new.get_resource_from_current_choice(choice_selection)
     p resources
     resources.each_index { |i|
                                 @display_item = Struct.new(:name, :value).new
                                 @display_item.name = resources[i][2]
                                 @display_item.value = resources[i][3]
                                 @values << @display_item
                          }
     return @values
   end
end