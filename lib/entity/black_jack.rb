require 'pry'
require './lib/entity/deck'
require './lib/entity/game_interface'

module Entity
  class BlackJack < GameInterface
    def start_game!
      players
        .each { |player| player.hand = deck.draw(2) }
        .each { |player| check_hand(player) }
        .shuffle!

      players
        .select { |player| black_jack?(player) }
        .each { |player| win!(player) }
    end

    def play!(player, operator, opts = {})
      case operator
      when :hit
        hit!(player)
        check_hand(player)
      when :stand
        stand!(player)
      end
    end

    private

    def check_hand(player)
      # TODO: 本当は10,11,12,13の場合は10として扱う
      # TODO: 1の場合は11か1として扱う
      player.score = player.hand.sum(&:number)
    end

    def black_jack?(player)
      player.score == 21
    end

    def win!(player)
      player.won = true
    end

    def hit!(player)
      player.hand =  player.hand + deck.draw(1)
    end
  end
end
