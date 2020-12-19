# frozen_string_literal: true

require './computer'
require './player'
require './mastermind'

VALID_COLORS = %w[A B C D E F].freeze
code_length = 4
max_turns = 10

#explainatory text
puts '---------------------------------------------------------------'
puts 'Welcome to Mastermind, agent.'
puts
puts "This computer will randomly pick a 4 letter passcode from #{VALID_COLORS.join} "
puts '(multiples of the same letter may be possible). '
puts
puts 'Your mission, should you choose to accept it, will be to crack '
puts 'this code.'
puts
puts "You will be given #{max_turns} attempts. After each attempt, you will be "
puts 'given 2 pieces of information:'
puts
puts '  1) the number of letters that are in the correct position.'
puts '  2) the number of letters that are correct, but in the wrong '
puts '     position.'
puts
puts "After #{max_turns} attempts, you will be locked out of the system, and it "
puts 'will be GAME OVER.'
puts
puts 'Good luck!'
puts
puts

loop do
  computer = Computer.new
  player = Player.new
  game = Mastermind.new(player, computer, VALID_COLORS, code_length, max_turns)
  break unless game.start_game
end
puts
puts "Goodbye, agent."