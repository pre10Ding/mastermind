# frozen_string_literal: true

require './mastermindFeedback'
# computer class for AI activities
class Computer
  include MastermindFeedback

  def initialize(difficulty = 'normal')
    @difficulty = difficulty
  end

  # returns a randomly generated 4 letter string composed of letters in valid_colors
  def get_input(_question_to_display, valid_characters, length, feedback = nil)
    feedback.nil? ? make_code(valid_characters, length) : get_guess(valid_characters, length, feedback)
  end

  def make_code(valid_characters, length)
    code = []
    length.times { code << valid_characters[rand(valid_characters.length)] }
    code.join
  end

  def get_guess(valid_characters, length, feedback)
    code = 'AAAA'
    return code
  end
end
