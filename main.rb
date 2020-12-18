# frozen_string_literal: true

require './computer'
require './player'
require './mastermind'

VALID_COLORS = %w[R G B P O Y].freeze
code_length = 4

computer = Computer.new
player = Player.new
game = Mastermind.new(player, computer, code_length)
p game.start_game(VALID_COLORS)
