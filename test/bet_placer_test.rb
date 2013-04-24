require 'test_helper'

class BetPlacerTest < MiniTest::Unit::TestCase
  def setup
    @bet_placer = CasinoBot::BetPlacer.new 'red'
  end
  
  def test_place_bet
    assert_equal "c:3,3\n", @bet_placer.place_bet('red')
  end
  
  def test_place_bet_black
    assert_equal "c:4,4\n", @bet_placer.place_bet('black')
  end
  
  def test_spin
    assert_equal "c:5,5\n", @bet_placer.spin
  end
  
  def test_focus_window
    assert_equal "c:11,11\n", @bet_placer.focus_window
  end
  
  def test_bet
    @bet_placer.expects(:bet_with_25).with('black', 2)
    @bet_placer.expects(:bet_with_10).with('black', 1)
    @bet_placer.expects(:bet_with_1).with('black', 4)
    @bet_placer.bet 'black', 64
  end
  
  def test_bet_with_100
    @bet_placer.expects(:click).with(11, 11)
    @bet_placer.expects(:click).with(6, 6)
    @bet_placer.expects(:click).with(4, 4)
    @bet_placer.bet_with_100 'black', 1
  end
  
  def test_bet_with_25
    @bet_placer.expects(:click).with(11, 11)
    @bet_placer.expects(:click).with(7, 7)
    @bet_placer.expects(:click).with(4, 4)
    @bet_placer.bet_with_25 'black', 1
  end
  
  def test_bet_with_10
    @bet_placer.expects(:click).with(11, 11)
    @bet_placer.expects(:click).with(8, 8)
    @bet_placer.expects(:click).with(4, 4)
    @bet_placer.bet_with_10 'black', 1
  end
  
  def test_bet_with_5
    @bet_placer.expects(:click).with(11, 11)
    @bet_placer.expects(:click).with(9, 9)
    @bet_placer.expects(:click).with(4, 4)
    @bet_placer.bet_with_5 'black', 1
  end
  
  def test_bet_with_100
    @bet_placer.expects(:click).with(11, 11)
    @bet_placer.expects(:click).with(10, 10)
    @bet_placer.expects(:click).with(4, 4)
    @bet_placer.bet_with_1 'black', 1
  end
end