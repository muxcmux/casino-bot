require 'test_helper'

class UtilTest < MiniTest::Unit::TestCase
  include CasinoBot::Util
  
  def test_logger_returs_logger
    CasinoBot.expects(:logger)
    logger
  end
  
  def test_rest
    100.times do
      assert rest(5, 10) >= 5
      assert rest(5, 10) <= 10
    end
  end
  
  def test_time_in_words
    assert_equal "less than a minute", time_in_words(40)
    assert_equal "5 minutes", time_in_words(320)
    assert_equal "1 hour and 15 minutes", time_in_words(4520)
    assert_equal "more than 72 hours", time_in_words(288_000)
  end
  
  def test_announce_spree
    (2..10).each do |i|
      assert announce_spree(i) =~ /\/assets\/(doublekill|tripplekill|killingspree|dominating|megakill|unstoppable|wickedsick|monsterkill|godlike|holyshit|ownage).wav/
    end
  end
  
  def test_play_sound
    assert_equal "#{CasinoBot.root}/assets/ownage.wav\n", play_sound('ownage')
  end
  
  def test_format_number
    assert_equal "12,345", format_number(12345)
    assert_equal "-1,234", format_number(-1234)
  end
end