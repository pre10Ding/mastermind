# frozen_string_literal: true

require './mastermindFeedback'
# main game logic
class Mastermind
  include MastermindFeedback

  def initialize(player, valid_colors, code_length = 4, max_turns = 10)
    @player = player
    @code_length = code_length
    @max_turns = max_turns
    @valid_colors = valid_colors
  end

  def choose_game_mode
    question_to_display = 'Would you like to play as the code breaker? (Y/N)'
    @player.get_input(question_to_display) == 'Y'
  end

  def setup(code_breaker, code_maker)
    @code_breaker = code_breaker
    @code_maker = code_maker
    @all_feedback = []
    @all_input = []
    reset_both_players # for new game loops
    question_to_display = 'Please enter a passcode for the computer to guess.'
    question_to_display += "\nChoose from #{@valid_colors.join}. (ie. \"ABBC\")"
    @code = @code_maker.get_input(question_to_display, @valid_colors, @code_length)
  end

  def start_game
    @max_turns.times do |turns_elapsed| # loop until guess matches or turns are done
      @all_input << prompt_for_guess
      print_feedback
      if @code == @all_input.last # code broken... ***NEED REFACTORING*** into Player/Computer instead
        puts "Congradulations! You broke the code on turn #{turns_elapsed + 1}!"
        break
      end
      puts "Game Over!\nThe code was #{@code}." unless turns_elapsed < @max_turns - 1
    end
    play_again?
  end

  private

  def print_feedback
    @all_feedback << provide_feedback(@all_input.last, @code)
    puts "Number of correct characters in the correct position:   #{@all_feedback.last[:match_pos]}"
    puts "Number of correct characters in the wrong position:     #{@all_feedback.last[:match_color]}"
    print_guess_history
  end

  def prompt_for_guess
    question_to_display = "Please enter your guess. (Choose from #{@valid_colors.join} ie. \"ABBC\")"
    matched = @all_feedback.last.nil? ? nil : [@all_feedback.last[:match_pos], @all_feedback.last[:match_color]]
    @code_breaker.get_input(question_to_display, @valid_colors, @code_length, matched)
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
    question_to_display = 'Do you want to play again? (Y/N)'
    @player.get_input(question_to_display) == 'Y'
  end

  def reset_both_players
    @code_breaker.reset
    @code_maker.reset
  end
end
