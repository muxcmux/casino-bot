module CasinoBot
  module Util
    def logger
      CasinoBot.logger
    end
    
    def rest from, to
      sleep((rand * (to - from) + from).round(2))
    end
    
    def format_number number
      if number.to_f >= 0
        number.to_i.to_s.reverse.scan(/.{1,3}/).join(',').reverse
      else
        "-" << number.to_i.to_s[1..-1].reverse.scan(/.{1,3}/).join(',').reverse
      end
    end
    
    def time_in_words s
      minutes = (s / 60).round
      case
        when minutes < 1
          "less than a minute"
        when minutes < 60
          minutes == 1 ? "one minute" : "#{minutes} minutes"
        when minutes < 4320
          hours = (minutes / 60).round
          and_minutes = minutes % 60
          and_minutes != 0 ? "#{hours} #{hours == 1 ? "hour" : "hours"} and #{and_minutes} #{and_minutes == 1 ? "minute" : "minutes"}" : "#{hours} #{hours == 1 ? "hour" : "hours"}"
        else
          "more than 72 hours"
      end
    end
    
    def announce_spree spree
      if spree >= 4
        Thread.new do
          sleep 1.1
          play_sound 'ownage'
        end
      end
      if spree == 2
        logger.info('DOUBLE KILL!')
        play_sound 'doublekill'
      elsif spree == 3
        logger.info('KILLING SPREE!')
        Thread.new do
          sleep 1.2
          play_sound 'tripplekill'
        end
        play_sound 'killingspree'
      elsif spree == 4
        logger.info('DOMINATING!')
        play_sound 'dominating'
      elsif spree == 5
        logger.info('MEGA KILL!')
        play_sound 'megakill'
      elsif spree == 6
        logger.info('UNSTOPPABLE!')
        play_sound 'unstoppable'
      elsif spree == 7
        logger.info('WICKED SICK!')
        play_sound 'wickedsick'
      elsif spree == 8
        logger.info('M-M-M-M-M-MONSTER KILL!')
        play_sound 'monsterkill'
      elsif spree == 9
        logger.info('GODLIKE!')
        play_sound 'godlike'
      elsif spree > 9
        logger.info('HOLY SHIT!')
        play_sound 'holyshit'
      end
    end
    
    def play_sound sound
      `#{CasinoBot.config['afplay_bin']} #{CasinoBot.root << "/assets/#{sound}.wav"}`
    end
  end
end