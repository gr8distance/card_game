module Entity
  class Player
    attr_reader :name
    attr_accessor :hand, :score, :stand, :current, :won

    def initialize(name)
      @name = name
      @hand = []
      @score = 0
      @stand = false
      @current = false
      @won = false
    end

    def drop_card(drop)
      hand.delete(drop)
    end

    def current?
      current
    end
  end
end
