require File.dirname(__FILE__) + "../../../SQLite/lite_query"

class Read
  attr_accessor :save_rows
  def initialize
    @query = LiteQuery.new
    @displayable_data = Array.new
    @save_rows = @query.get_saves
  end

  def project_displayable_contents
    @save_rows.each_index { |i| @displayable_data << @save_rows[i][3].split("\\").last }
    return @displayable_data
  end
end