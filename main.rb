require 'pry'
require './lib/entity/deck'
require './lib/entity/player'
require './lib/entity/poker'
require './lib/entity/black_jack'
require './lib/use_case/game'

players = %w[alice bob charlie].map do |name|
  Entity::Player.new(name: name)
end

# poker.start_game!
# players.each do |player|
#   poker.check_hand(player)
# end
#
# p = players.first
#
# # TODO: handをdupして渡さないとhit!できない
# poker.hit!(p, p.hand.dup)

poker = Entity::Poker.new(players: players)
bj = Entity::BlackJack.new(players: players)

game = UseCase::Game.new(bj)
game.play
