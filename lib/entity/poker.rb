require './lib/entity/deck'
require './lib/entity/game_interface'
require 'pry'

module Entity
  class Poker < GameInterface
    def start_game!
      players
        .each { |player| player.hand = deck.draw(5) }
        .each { |player| check_hand(player) }
        .shuffle!
    end

    def check_hand(player)
      case
      when royal_staright_flush?(player.hand)
        player.score = 10
      when straight_flush?(player.hand)
        player.score = 9
      when full_house?(player.hand)
        player.score = 8
      when straight?(player.hand)
        player.score = 7
      when flush?(player.hand)
        player.score = 6
      when five_card?(player.hand)
        player.score = 5
      when four_card?(player.hand)
        player.score = 4
      when three_card?(player.hand)
        player.score = 3
      when two_pair?(player.hand)
        player.score = 2
      when one_pair?(player.hand)
        player.score = 1
      else
        player.score = 0
      end
    end

    def play!(player, operator, opts = {})
      case operator
      when :hit
        hit!(player, opts[:drop].dup)
        check_hand(player)
      when :stand
        stand!(player)
      end
    end

    private

    def hit!(player, drops)
      raise 'Drop card is greater than or equal to 1' if drops.length == 0

      drops.each do |drop|
        player.drop_card(drop)
      end
      player.hand = player.hand + deck.draw(drops.length)
    end

    def stand!(player)
      player.stand = true
    end

    def royal_staright_flush?(hand)
      false
    end

    def straight_flush?(hand)
      straight_flush?(hand) && flush?(hand)
    end

    def full_house?(hand)
      two_pair?(hand) && three_card?(hand)
    end

    def straight?(hand)
      hand.map(&:number).sort.each_cons(2).all? { |a, b| a + 1 == b }
    end

    def flush?(hand)
      hand.map(&:type).uniq == 1
    end

    def one_pair?(hand)
      hand.group_by(&:number).select { |_, v|
        v.size == 2
      }.length == 1
    end

    def two_pair?(hand)
      hand.group_by(&:number).select { |_, v|
        v.size == 2
      }.length == 2
    end

    def three_card?(hand)
      hand
        .group_by(&:number)
        .select { |_, v| v.size == 3 }
        .length == 1
    end

    def four_card?(hand)
      hand
        .group_by(&:number)
        .select { |_, v| v.size == 4 }
        .length == 1
    end
  end
end
