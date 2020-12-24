# frozen_string_literal: true

require './computer'
require './player'
require './mastermind'

VALID_COLORS = %w[A B C D E F].freeze
CODE_LENGTH = 4
MAX_PLAYER_TURNS = 8

computer = Computer.new
player = Player.new
game = Mastermind.new(player, VALID_COLORS, CODE_LENGTH)
code_breaker = nil
code_maker = nil

loop do # role selection loop to keep the player playing
  # introductions
  puts '---------------------------------------------------------------'
  puts "Welcome to Mastermind, agent.\n\n"
  game_mode = game.choose_game_mode

  if game_mode # player chooses code breaker role
    max_turns = MAX_PLAYER_TURNS
    code_breaker = player
    code_maker = computer
    File.foreach('code_breaker_intro.txt') { |line| puts line }

  elsif !game_mode.nil? # player chooses code maker role
    max_turns = MAX_PLAYER_TURNS / 2
    code_breaker = computer
    code_maker = player
    File.foreach('code_maker_intro.txt') { |line| puts line }

  else
    break # game_mode will return nil if the player doesnt want to play anymore
  end

  puts
  puts
  loop do # gameplay loop to stay in the same role
    game.setup(code_breaker, code_maker, max_turns) # the computer needs to be reset every round
    break unless game.start_game # need to add logic to go back to mode select
  end
  puts
  puts
end

puts 'Good work, agent! See you again next time.'
