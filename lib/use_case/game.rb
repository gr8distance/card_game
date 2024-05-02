require 'pry'
require './lib/entity/deck'
require './lib/entity/player'
require './lib/entity/poker'

module UseCase
  class Game
    attr_reader :game

    def initialize(game)
      @game = game
      @game.start_game!
    end

    def play
      # NOTE: 本当はここでゲームの進行管理を行う
      game.players.each do |player|
        binding.pry
        # game.play(player, opeartor, opts)
      end
    end
  end
end
