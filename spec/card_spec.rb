require 'card'

describe Card do
  subject(:card) {Card.new(:spades, :ace)}

  describe '#suit' do
    it 'returns a suit' do
      expect(card.suit).to eq(:spades)
    end
  end

  describe '#value' do
    it 'returns a value' do
      expect(card.value).to eq(:ace)
    end
  end
end
