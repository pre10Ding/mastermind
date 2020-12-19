# frozen_string_literal: true

# main game logic
class Mastermind
  def initialize(player, ai_player, valid_colors, code_length = 4, max_turns = 10)
    @player = player
    @ai = ai_player
    @code_length = code_length
    @max_turns = max_turns
    @valid_colors = valid_colors
    @all_feedback = []
    @all_input = []
    @code = @ai.make_code(@valid_colors, @code_length)
  end

  def start_game
    @max_turns.times do |turns_elapsed| # loop until guess matches or turns are done
      @all_input << validate_input('guess')
      if @code == @all_input.last # code broken
        puts "Congradulations #{@player.name}! You broke the code on turn #{turns_elapsed + 1}!"
        break
      end
      provide_feedback(@all_input.last.chars, @code.chars)
      puts "Game Over!\nThe code was #{@code}." unless turns_elapsed < @max_turns - 1
    end
    play_again?
  end

  def validate_input(guess_or_code)
    input = false
    loop do
      puts "Please enter your #{guess_or_code}. (Choose from #{@valid_colors.join} ie. \"ABBC\")"
      input = @player.prompt.upcase
      # subtracting sets leaves an empty if all eles in the first set exist in 2nd
      break if input.length == @code_length && (input.chars - @valid_colors).empty?

      puts "Invalid input, please enter your #{guess_or_code} again."
    end
    input
  end

  def provide_feedback(input, code)
    feedback = {
      match_pos: 0,
      match_color: 0,
      input: input,
      code: code
    }

    @all_feedback << count_correct_pos_and_color(feedback) # count the number of correct pos
    puts "Number of correct characters in the correct position:   #{feedback[:match_pos]}"
    puts "Number of correct characters in the wrong position:     #{feedback[:match_color]}"
    print_guess_history
  end

  def count_correct_pos_and_color(feedback)
    code = feedback[:code].clone
    match_pos = 0
    feedback[:input].clone.each_with_index do |ele, index|
      next if ele != code[index]

      feedback[:code].delete_at(index - match_pos)
      feedback[:input].delete_at(index - match_pos)
      match_pos += 1
    end
    feedback[:match_pos] = match_pos
    count_correct_color(feedback) # returning this so that it can be tracked in @all_feedback
  end

  def count_correct_color(feedback)
    input = feedback[:input].clone
    match_color = 0
    input.each_with_index do |ele, index|
      next unless feedback[:code].include?(ele)

      feedback[:input].delete_at(index - match_color)
      feedback[:code].delete_at(feedback[:code].index(ele))
      match_color += 1
    end
    feedback[:match_color] = match_color
    feedback # returning this so that it can be tracked in @all_feedback
  end

  def print_guess_history
    puts 'Here are your guesses so far:'
    bar = '-' * 32
    puts "|#{bar}|\n| Turn | Guess | \u2713 Pos | \u2713 Color |\n|#{bar}|"
    @all_input.each_with_index do |guess, index|
      print "|  #{(index + 1).to_s.rjust(2, '0')}  | #{guess}  |"
      print "   #{@all_feedback[index][:match_pos]}   |"
      puts "    #{@all_feedback[index][:match_color]}    |"
    end
    puts "|#{bar}|"
  end

  def play_again?
    player_choice = false
    loop do
      puts 'Do you want to play again? (Y/N)'
      input = @player.prompt.upcase
      if %w[Y N].include?(input)
        player_choice = input == 'Y'
        break
      end
    end
    player_choice
  end
end
