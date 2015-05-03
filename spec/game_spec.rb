require 'game'

describe Game do
  let(:player1){double("player1")}
  let(:player2){double("player2")}
  let(:player3){double("player3")}
  let(:players){ [player1, player2, player3]}
  let(:game){Game.new(players)}

  describe '#initialize' do
    it 'starts a game with a deck of 52 cards' do
      expect(game.deck.count).to eq(52)
    end

    it 'holds a varying number of players' do
      expect(game.players.count).to eq(3)
    end

  end

  describe '#turn' do

    it 'implements turns' do
      
    end



    it 'tracks the pot per turn'
  end

  describe '#take_bets' do
    it 'tracks bets made by players'
  end






end
