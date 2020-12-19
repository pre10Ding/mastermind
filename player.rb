# frozen_string_literal: true

# Player class
class Player
  def initialize(name = 'Player 1')
    @name = name
  end

  attr_reader :name

  # asks user for input and returns the move
  def prompt
    gets.chomp
  end

  def get_input(question_to_display, valid_characters = %w[Y N], length = 1, _feedback = nil)
    input = false
    loop do
      puts question_to_display
      input = prompt.upcase
      # subtracting sets leaves an empty if all eles in the first set exist in 2nd
      break if input.length == length && (input.chars - valid_characters).empty?

      puts 'Invalid input.'
    end
    input
  end
end
