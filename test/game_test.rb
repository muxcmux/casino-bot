require 'test_helper'

class GameTest < MiniTest::Unit::TestCase
  def setup
    @game = CasinoBot::Game.new
  end
  
  def play_and_win win = true
    CasinoBot::BetPlacer.any_instance.expects(:bet)
    @game.expects(:spin_and_win!).returns(win)
    @game.play!
  end
  
  def assert_state profit, wager, winning_spree, losing_spree, rounds
    assert_equal profit, @game.instance_variable_get(:@profit)
    assert_equal wager, @game.instance_variable_get(:@wager)
    assert_equal winning_spree, @game.instance_variable_get(:@winning_spree)
    assert_equal losing_spree, @game.instance_variable_get(:@losing_spree)
    assert_equal rounds, @game.instance_variable_get(:@rounds)
  end
  
  def test_a_game_run
    3.times { play_and_win }
    assert_state 3, 1, 3, 0, 3
    2.times { play_and_win(false) }
    assert_state 0, 4, 0, 2, 5
    play_and_win
    assert_state 4, 1, 1, 0, 6
    play_and_win(false)
    assert_state 3, 2, 0, 1, 7
    2.times { play_and_win }
    assert_state 6, 1, 2, 0, 9
    6.times { play_and_win(false) }
    assert_state -57, 64, 0, 6, 15
    play_and_win
    assert_state 7, 1, 1, 0, 16
  end
  
  def test_change_bet_color
    @game.instance_variable_set(:@color, 'black')
    @game.change_bet_color
    assert 'red', @game.instance_variable_get(:@color)
  end
  
  def test_calculate_profit_correctly
    5.times { play_and_win }
    assert_equal 5, @game.instance_variable_get(:@profit)
  end
  
  def test_abort_when_limit_is_reached
    15.times do |i|
      play_and_win(false)
    end
    assert @game.instance_variable_get(:@game_has_aborted)
    # The actual last bet made should be 128 (for 8 consecutive losses),
    # but since it was a loss, the @wager gets doubled
    # after the fact you've lost, hence it's 256 now.
    assert_equal 256, @game.instance_variable_get(:@last_bet)
  end
  
  def test_spin_and_win!
    CasinoBot::BetPlacer.any_instance.expects(:spin)
    CasinoBot::Analyzer.any_instance.expects(:win?)
    @game.spin_and_win!
  end
  
  def test_game_stop
    game = CasinoBot::Game.new
    play_and_win
    game.stop!
    assert_equal 0, game.game_time # well, that was a quick game
  end
end