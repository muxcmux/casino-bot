require 'casino_bot/clicker'

module CasinoBot
  class BetPlacer
    include CasinoBot::Clicker
    
    def initialize color
      @color = color
      @coords = CasinoBot.config['click_coordinates']
      @nominals = [100, 25, 10, 5, 1]
    end
    
    def place_bet color
      @color = color
      focus_window
      click @coords[@color]['x'], @coords[@color]['y']
    end
    
    def spin
      focus_window
      click @coords['spin']['x'], @coords['spin']['y']
    end
    
    def focus_window
      click @coords['focus_window']['x'], @coords['focus_window']['y']
    end
    
    def bet color, sum
      @nominals.each do |nominal|
        t = (sum/nominal).ceil
        send("bet_with_#{nominal}".to_sym, color, t)
        sum = sum - t * nominal
      end
    end
    
    [100, 25, 10, 5, 1].each do |nominal|
      class_eval <<-END
        def bet_with_#{nominal} color, t
          if t > 0
            click @coords[#{nominal}]['x'], @coords[#{nominal}]['y']
            t.times { place_bet color }
          end
        end
      END
    end
  end
end