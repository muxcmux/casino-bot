require 'test_helper'

class AnalyzerTest < MiniTest::Unit::TestCase
  def setup
    @analyzer = CasinoBot::Analyzer.new 'red', black_ref: '/test/fixtures/black.png', red_ref: '/test/fixtures/red.png'
  end
  
  def test_take_screenshot
    assert_equal "-R2,2,10,10 #{CasinoBot.root}/tmp/screenshot.png\n", @analyzer.take_screenshot
  end
  
  def test_analyze_red_is_red
    @analyzer.instance_variable_set(:@screenshot, @analyzer.instance_variable_get(:@reference_images)['red'])
    assert_equal 100.0, @analyzer.analyze
  end
  
  def test_analyze_black_is_not_red
    @analyzer.instance_variable_set(:@screenshot, @analyzer.instance_variable_get(:@reference_images)['black'])
    assert_equal 13.36, @analyzer.analyze
  end
  
  def test_load_screenshot
    ChunkyPNG::Image.expects(:from_file).with(@analyzer.instance_variable_get(:@tmpfile))
    @analyzer.load_screenshot
  end
  
  def test_cleanup
    refute File.exists?(@analyzer.instance_variable_get(:@tmpfile)), @analyzer.cleanup
  end
  
  def test_win
    @analyzer.instance_variable_set(:@screenshot, @analyzer.instance_variable_get(:@reference_images)['red'])
    @analyzer.stubs(:load_screenshot)
    @analyzer.stubs(:take_screenshot)
    @analyzer.stubs(:cleanup)
    assert @analyzer.win? 'red'
    refute @analyzer.win? 'black'
  end
end