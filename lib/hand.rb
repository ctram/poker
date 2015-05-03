require_relative 'deck'

class EmptyHandError < StandardError
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def discard(target_card)
    raise EmptyHandError if @cards.empty?
    @cards.each_with_index do |card, i|
      @cards.delete_at(i) if target_card == card
    end
  end


  def high_card
    # debugger
    return nil if @cards.empty?
    sorted_cards = @cards.sort_by do |card|
      SYMBOLS_TO_VALUES[card.value]
    end

    sorted_cards.last.value
  end

  def one_pair
    return nil if @cards.empty?
    values_found = []
    @cards.each do |card|
      if values_found.include? card.value
        return card.value
      else
        values_found << card.value
      end
    end
  end

  def two_pairs
    values_found = []
    pairs_found = []
    @cards.each do |card|
      if values_found.include? card.value
        pairs_found << card.value
      else
        values_found << card.value
      end
    end
    if pairs_found.uniq.count > 2
      return nil
    end
    pairs_found
  end

  def three_of_a_kind
    uniq_values = []
    @cards.each do |card|
      uniq_values << card.value
    end
    uniq_values.uniq!

    uniq_values.each do |value|
      num_times_appear = 0
      @cards.each do |card|
        if value == card.value
          num_times_appear += 1
        end
      end

      if num_times_appear == 3
        return value
      end
    end
    nil
  end

  def straight
    lowest_card = @cards.sort_by{|card| Card::SYMBOLS_TO_VALUES[card.value]}.first

    highest_card = @cards.sort_by{|card| Card::SYMBOLS_TO_VALUES[card.value]}.last

    if Card::SYMBOLS_TO_VALUES[highest_card.value] - Card::SYMBOLS_TO_VALUES[lowest_card.value] == 4
       high_card
     else
       nil
     end
  end

  def flush
    suits = []
    values = []
    @cards.each do |card|
      suits << card.suit
      values << card.value
    end
    if suits.uniq!.count == 1
      values
    else
      nil
    end
  end

  def full_house
    if one_pair and three_of_a_kind
      high_card
    else
      nil
    end
  end

  def four_of_a_kind
    values = []
    @cards.each do |card|
      values << card.value
    end
    values.uniq!.each do |value|
      num_times_appear = 0
      @cards.each do |card|
        if card.value == value
          num_times_appear += 1
        end
      end
      if num_times_appear == 4
        return value
      end
    end
    nil
  end

  def straight_flush
    if straight and flush
      high_card
    else
      nil
    end
  end

  def royal_flush
    if straight and flush and high_card == :ace
      :ace
    end
  end

  private

  def find_card(suit, value)
    found_card = nil

    @cards.each do |card|
      if card.suit == suit && card.value == value
        found_card = card
      end
    end

    found_card
  end

end
