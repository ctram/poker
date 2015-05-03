class Game

  attr_accessor :deck
  attr_reader :players

  def initialize(players)
    @deck = Deck.new
    @players = players
  end

end
