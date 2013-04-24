# Casino bot

[![Build Status](https://travis-ci.org/muxcmux/casino-bot.png?branch=master)](https://travis-ci.org/muxcmux/casino-bot)

A tiny program that will make you rich beyond all measure! (nah, it probably won't)

### You need:

* Ruby 2.0.0 (1.9.3 should work)
* A Mac

### Install:

* Clone this repo

        $ git clone git@github.com:muxcmux/casino-bot.git

* Install dependencies
        
        $ bundle install

### Configure:

First, copy `config/bot.yml.example` to `config/bot.yml` and edit appropriately. You'll have to keep an open tab on the roulette game. To figure out mouse coordinates, you can do one of two things:

1. Pres Cmd + Shift + 4. A Crosshair with coordinates will appear.
2. Move your mouse to a given position and then to see your mouse coords run
        
        $ bundle exec bin/cliclick p

Next, you need to take two reference screenshots. Spin the roulette and wait for it to finish. When it ends, run 
    
    $ bundle exec rake refscreens
    
Follow the instructions. Make sure that both `tmp/black.png` and `tmp/red.png` are the correct reference images.

### Test

    $ bundle exec rake test
    
Tests should run on your average CI server (OSX specific binaries are replaced with `echo` in the test environment). Running the tests generates coverage report in `coverage/index.html`

### Run:

* Open the roulette game in your browser
* Run 
        
        $ bundle exec bin/bot your_starting_balance
        
  where `your_starting_balance` is an int > 0

* PROFIT! (until you go bankrupt)

### Sprees:

Sprees are announced in Unreal Tournament style (also DoTA). Turn up you speakers to hear them when you are on a winning spree. Alternatively, you can test them just for phun with a rake task where `num` is an int between 2 and 10 :D

    $ bundle exec rake spree[num]

### Online casinos with roulette games (feel free to add more!):

* http://www.eucasino.com/instant-play.html