$:.unshift(File.expand_path('../', __FILE__))

require 'bundler'
Bundler.setup :default

require 'yaml'
require 'logger'

module CasinoBot
  VERSION = '0.3'
  
  def self.root
    File.expand_path('../../', __FILE__)
  end
  
  def self.config
    @config ||= YAML.load_file(CasinoBot.root << '/config/bot.yml')
  end
  
  def self.logger
    return @logger unless @logger.nil?
    logger = Logger.new(@config['log'] || STDOUT)
    logger.datetime_format = '%Y-%m-%d %H:%M:%S'
    logger.formatter = proc do |severity, datetime, progname, msg|
      "##{Process.pid} #{datetime} [#{severity}] #{msg}\n"
    end
    @logger = logger
  end
end

require 'casino_bot/game'