class Tester
###TEST#####TEST####TEST########TEST#########

  def initialize
@query = LiteQuery.new
file_path = "C:/Users/Jake/VIsual Studio 2010/Projects/ResourceManager/resource_manager.resx"
@query.insert_save(file_path)

@query.insert_resource_values_to_set(1,'variable', 'over9000')
@query.insert_resource_values_to_set(1,'variable2', 'over9001')
@query.insert_resource_values_to_set(1,'variable3', 'over9002')

@query.insert_resource_values_to_set(2,'variable4', 'over12000')
@query.insert_resource_values_to_set(2,'variable5', 'over12001')
@query.insert_resource_values_to_set(2,'variable6', 'over12002')

saves = @query.get_saves
pairs = @query.get_resource_set(2)

puts saves
puts "~~~~~~~~~end~save~file~~~~~~~~~~~~~"
puts pairs
puts "~~~~~~~~~end~of~pairs~~~~~~~~~~~~~"
  end
end