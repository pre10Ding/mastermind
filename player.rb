# frozen_string_literal: true

# Player class
class Player
  def initialize(name = 'Player 1')
    @name = name
  end

  # asks user for input and returns the move
  def prompt
    gets.chomp
  end
end
