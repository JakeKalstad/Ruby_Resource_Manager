require File.dirname(__FILE__) + '/../../SaveOffs/Read/read_save'
require File.dirname(__FILE__) + '/../../Parser/node_manufacturer'

class ResxPresenter

   def retrieve_contents_from_path(path)
     return retrieve_contents(path)
   end

   def retrieve_contents_from_choice(choice_selection)
     @hot_word = choice_selection
     self.locate_file_and_retrieve_contents
     return @list
   end

   def locate_file_and_retrieve_contents
      @save_file = Read.new.receive_file_contents
      @content = @save_file.each_index { |i|
                                             if @save_file[i].include?(@hot_word)
                                                  @path =  @save_file[i]
                                             end
                                       }
      retrieve_contents(@path)
   end

   def retrieve_contents(path)
    @manufacturer = Node_Manufacturer.new(path.tr_s('\\','/').to_s)
    @list =  @manufacturer.resource_tuple_list
   end
end