# frozen_string_literal: true

# main game logic
class Mastermind
  def initialize(player, ai_player, code_length)
    @player = player
    @ai = ai_player
    @code_length = code_length
  end

  def start_game(valid_colors)
    @valid_colors = valid_colors
    @ai.make_code(valid_colors, @code_length)
    input = false
    until input
      puts 'Please enter your guess. (ie. \"RBBG\")'
      input = validate_input(@player.prompt.upcase)
    end
  end

  def validate_input(input)
    # subtracting sets leaves an empty if all eles in the first set exist in 2nd
    return input if input.length == @code_length && (input.chars - @valid_colors).empty?

    puts 'Invalid input, please enter your guess again.'
    false
  end
end
