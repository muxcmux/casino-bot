require 'casino_bot/bet_placer'
require 'casino_bot/analyzer'
require 'casino_bot/util'
require 'date'

module CasinoBot
  class Game
    include CasinoBot::Util
    
    attr_reader :starting_balance, :profit, :rounds, :game_time
    
    def initialize starting_balance = 0
      @starting_balance = starting_balance.to_i
      @wager = 1
      @rounds = 0
      @profit = 0
      @losing_spree = 0
      @winning_spree = 0
      @losing_spree_limit = CasinoBot.config['losing_spree_limit'].to_i
      @color = %w(red black).sample
      @bet_placer = CasinoBot::BetPlacer.new @color
      @analyzer = CasinoBot::Analyzer.new @color
      @game_started_at = DateTime.now
      @game_time = nil
    end
    
    def play!
      abort if @losing_spree >= @losing_spree_limit
      rest 1, 3
      @rounds += 1
      logger.info("Started round #{@rounds}.")
      logger.info("Placing #{@wager} EUR on #{@color}")
      @bet_placer.bet @color, @wager
      @profit -= @wager
      if spin_and_win!
        @color = change_bet_color
        @profit += @wager * 2
        @winning_spree += 1
        @losing_spree = 0
        @wager = 1
        announce_spree @winning_spree
      else
        @winning_spree = 0
        @losing_spree += 1
        @wager = @wager * 2
      end
    end
    
    def stop!
      @game_time = ((DateTime.now - @game_started_at) * 24 * 60 * 60).to_i
    end
    
    def abort
      logger.info("Losing spree limit reached. Killing process ##{Process.pid}")
      stop!
      exit
    end
    
    def spin_and_win!
      logger.info("Spinning the wheel...")
      @bet_placer.spin
      rest 9, 12
      @analyzer.win? @color
    end
    
    def change_bet_color
      @color == 'red' ? 'black' : 'red'
    end
  end
end