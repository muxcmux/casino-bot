require 'oily_png'
require 'yaml'
require 'casino_bot/util'

module CasinoBot
  class Analyzer
    attr_accessor :tmpfile
    include ChunkyPNG::Color
    include CasinoBot::Util
    
    def initialize color, options = {}
      black_ref = options[:black_ref] || '/tmp/black.png'
      red_ref = options[:red_ref] || '/tmp/red.png'
      @color = color
      @tmpfile = CasinoBot.root << "/tmp/screenshot.png"
      @reference_images = {
        'black' => ChunkyPNG::Image.from_file(CasinoBot.root << black_ref),
        'red' => ChunkyPNG::Image.from_file(CasinoBot.root << red_ref)
      }
    end
    
    def take_screenshot
      coords = CasinoBot.config['screenshot_coordinates'][@color]
      sc_bin = CasinoBot.config['screencapture_bin']
      args = [coords['x'], coords['y'], coords['width'], coords['height']]
      logger.info("Taking a #{coords['width']}x#{coords['height']} screenshot at #{coords['x']}, #{coords['y']}")
      `#{sc_bin} -R#{args.join(',')} #{@tmpfile}`
    end
    
    def load_screenshot
      @screenshot = ChunkyPNG::Image.from_file(@tmpfile)
    end
    
    def cleanup
      File.unlink(@tmpfile) if File.exists?(@tmpfile)
    end
    
    def analyze
      diff = []
      @screenshot.height.times do |y|
        @screenshot.row(y).each_with_index do |pixel, x|
          diff << [x,y] unless pixel == @reference_images[@color][x,y]
        end
      end
      similarity = (100 - ((diff.length.to_f / @screenshot.pixels.length) * 100)).round(2)
      logger.info("Screenshot similarity to #{@color}.png is #{similarity} %")
      similarity
    end
    
    def win? color
      @color = color
      take_screenshot
      load_screenshot
      similarity = analyze
      cleanup
      if similarity > 60.0 
        logger.info("Bet was a win")
        true
      else
        logger.info("Bet was a loss")
        false
      end
    end
  end
end