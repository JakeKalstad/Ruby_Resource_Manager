require File.dirname(__FILE__) + "../../../SQLite/lite_query"
require File.dirname(__FILE__) + "../../../SQLIte/table_extension"

class Read

  def initialize
    @query = LiteQuery.new
    @save_rows = @query.get_saves
  end

  def project_displayable_contents
    @displayable_data = Array.new
    @save_rows.each_index { |i| @displayable_data <<  Table_Extension.get_save_display_string(@save_rows, i).last if Table_Extension.is_active_save(@save_rows, i) }
    return @displayable_data
  end
end