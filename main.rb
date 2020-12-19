# frozen_string_literal: true

require './computer'
require './player'
require './mastermind'

VALID_COLORS = %w[R G B P O Y].freeze
code_length = 4
max_turns = 10

loop do
  computer = Computer.new
  player = Player.new
  game = Mastermind.new(player, computer, VALID_COLORS, code_length, max_turns)
  break unless game.start_game
end
