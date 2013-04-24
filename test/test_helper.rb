require 'rubygems'
require 'bundler'
Bundler.setup :default, :test
require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end
require 'turn'
require 'minitest/autorun'
require 'mocha/setup'
require 'webmock/minitest'
require 'casino_bot'

# fake config
CasinoBot.instance_variable_set(:@config, YAML.load_file(CasinoBot.root << '/test/fixtures/config_test.yml'))

# fake sleep
module CasinoBot
  module Util
    def sleep s
      s
    end
  end
end

# fake exit
module CasinoBot
  class Game
    def exit
      @last_bet = @wager unless @last_bet
      @game_has_aborted = true
    end
  end
end