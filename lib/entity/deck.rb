require './lib/entity/card'

module Entity
  class Deck < Array
    def initialize
      cards = %i[spade heart diamond club].flat_map do |suit|
        (1..13).map do |number|
          Card.new(number, suit)
        end
      end.shuffle.each do |card|
        self << card
      end
    end

    def draw(n)
      Array.new(n) do
        shift
      end
    end
  end
end
