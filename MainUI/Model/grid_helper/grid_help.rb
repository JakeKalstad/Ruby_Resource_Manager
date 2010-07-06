class GridHelp

end

class MyGridTable < Wx::GridTableBase
  attr_reader :cols, :rows
  def initialize(rows)
    super()
    @rows = rows
    @cols = 2
    @number_col = 1
  end

  COLS = ('Name').to_a
  COLS << 'Value'

  def get_number_rows
    @rows
  end

  def get_number_cols
    @cols
  end

  def get_value(row, col)
    if col == @number_col
      (row * 5).to_s
    else
      "#{row}:#{COLS[col]}"
    end
  end

  def get_attr(row, col, attr_kind)
    attr = Wx::GridCellAttr.new
    if (row % 2).zero?
      attr.text_colour = Wx::RED
    end
    attr
  end

  def is_empty_cell(row, col)
    false
  end

  def get_col_label_value(col)
    COLS[col]
  end

  def set_value(x, y, val)
    puts "Changing the value of cell (#{x}, #{y}) to '#{val}'"  
  end
end
