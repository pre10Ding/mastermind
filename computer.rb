# frozen_string_literal: true

# computer class for AI activities
class Computer
  def initialize(difficulty = 'normal')
    @difficulty = difficulty
  end

  # returns a randomly generated 4 letter string composed of letters in valid_colors
  def get_input(_question_to_display, valid_characters, length, feedback = nil)
    code = []
    length.times { code << valid_characters[rand(valid_characters.length)] } if feedback.nil?
    code.join
  end
end
