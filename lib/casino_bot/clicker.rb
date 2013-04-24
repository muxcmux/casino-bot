require 'casino_bot/util'

module CasinoBot
  module Clicker
    include CasinoBot::Util
    
    def click x, y
      rest 0.1, 0.6
      `#{CasinoBot.config['cliclick_bin']} c:#{x},#{y}`
    end
  end
end