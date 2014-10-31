require 'test_helper'

class MenuCellTest < Cell::TestCase
  test "list" do
    invoke :list
    assert_select "p"
  end
  

end
