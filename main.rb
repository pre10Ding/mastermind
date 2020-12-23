# frozen_string_literal: true

require './computer'
require './player'
require './mastermind'

VALID_COLORS = %w[A B C D E F].freeze
code_length = 4
max_player_turns = 8

computer = Computer.new
player = Player.new
game = Mastermind.new(player, VALID_COLORS, code_length, max_player_turns)
code_breaker = nil
code_maker = nil

# introduction
puts '---------------------------------------------------------------'
puts 'Welcome to Mastermind, agent.'
if game.choose_game_mode
  # explainatory text as code breaker
  puts '---------------------------------------------------------------'
  puts 'Greetings, code breaker.'
  puts
  puts "This computer will randomly pick a 4 letter passcode from #{VALID_COLORS.join} "
  puts '(multiples of the same letter may be possible). '
  puts
  puts 'Your mission, should you choose to accept it, will be to crack '
  puts 'this code.'
  puts
  puts "You will be given #{max_player_turns} attempts. After each attempt, you will be "
  puts 'given 2 pieces of information:'
  puts
  puts '  1) the number of letters that are in the correct position.'
  puts '  2) the number of letters that are correct, but in the wrong '
  puts '     position.'
  puts
  puts "After #{max_player_turns} attempts, you will be locked out of the system, and it "
  puts 'will be GAME OVER.'

  code_breaker = player
  code_maker = computer

else
  puts 'Greetings, code maker.'
  puts
  puts "You will be need to pick a 4 letter passcode from #{VALID_COLORS.join} for the"
  puts 'computer to break.'
  puts
  puts "The computer will be given #{max_player_turns} attempts. After each "
  puts 'attempt, it will be given 2 pieces of information:'
  puts
  puts '  1) the number of letters that are in the correct position.'
  puts '  2) the number of letters that are correct, but in the wrong '
  puts '     position.'
  puts
  puts "After #{max_player_turns} attempts, the computer will be locked out of the system."
  puts 'and you will be congradualated on coming up with a such a'
  puts 'secure passcode!'

  code_breaker = computer
  code_maker = player

end

puts
puts 'Good luck!'
puts
puts
loop do
  game.setup(code_breaker, code_maker) # the computer needs to be reset every round
  break unless game.start_game # need to add logic to go back to mode select
end
puts
puts 'Goodbye, agent.'
