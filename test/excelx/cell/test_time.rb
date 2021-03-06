require 'test_helper'

class TestRooExcelxCellTime < Minitest::Test
  def time
    Roo::Excelx::Cell::Time
  end

  def base_date
    Date.new(1899, 12, 30)
  end

  def test_formatted_value
    value = '0.0751' # 6488.64 seconds, or 1:48:08.64
    [
      ['h:mm', '1:48'],
      ['h:mm:ss', '1:48:09'],
      ['mm:ss', '48:09'],
      ['[h]:mm:ss', '[1]:48:09'],
      ['mmss.0', '4809.0'] # Cell::Time always get rounded to the nearest second.
    ].each do |style_format, result|
      cell = time.new(value, nil, [:numeric_or_formula, style_format], 6, nil, base_date, nil)
      assert_equal result, cell.formatted_value, "Style=#{style_format} is not properly formatted"
    end
  end

  def test_value
    cell = time.new('0.0751', nil, [:numeric_or_formula, 'h:mm'], 6, nil, base_date, nil)
    assert_kind_of Fixnum, cell.value
  end
end
