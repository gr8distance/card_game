require './lib/entity/deck'
require 'pry'

module Entity
  class GameInterface
    attr_reader :players, :deck
    def initialize(players: [])
      @players = players
      @deck = Deck.new
    end

    def start_game!
      raise NotImplementedError
    end

    def play!(player, operator, opts = {})
      raise NotImplementedError
    end

    private

    def check_hand(player)
      raise NotImplementedError
    end
  end
end
