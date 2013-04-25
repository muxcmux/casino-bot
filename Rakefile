require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << %w(test)
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = false
end

desc "Grabs reference screenshots"
task :refscreens do
  require_relative './lib/casino_bot'
  require 'fileutils'

  while true
    print "Ref screenshot (black|red|exit): "
    color = STDIN.gets.chomp.strip.downcase
    exit unless %w(red black).include?(color)
    print "Prepare your screen for #{color} screenshot (ok|cancel): "
    next unless STDIN.gets.chomp.strip.downcase == 'ok'
    3.downto(1) do |i|
      print "Taking screenshot in #{i}...\r"
      sleep 1
    end
    analyzer = CasinoBot::Analyzer.new color, black_ref: '/test/fixtures/black.png', red_ref: '/test/fixtures/red.png'
    analyzer.take_screenshot
    FileUtils.mv(analyzer.tmpfile, CasinoBot.root << "/tmp/#{color}.png")
    puts "Reference screenshot taken for #{color}"
  end
end

desc "Play sound for a winning spree!"
task :spree, :spree do |t, args|
  require_relative './lib/casino_bot'
  game = CasinoBot::Game.new 'red'
  game.announce_spree args[:spree].to_i
end