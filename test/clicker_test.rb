require 'test_helper'

class ClickerTest < MiniTest::Unit::TestCase
  include CasinoBot::Clicker
  
  def test_click
    assert_equal "c:500,500\n", click(500, 500)
  end
end