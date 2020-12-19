# frozen_string_literal: true

# computer class for AI activities
class Computer
  def initialize(difficulty = 'normal')
    @difficulty = difficulty
  end

  # returns a randomly generated 4 letter string composed of letters in valid_colors
  def make_code(valid_colors, code_length)
    code = []
    code_length.times { code << valid_colors[rand(valid_colors.length)] }
    code.join
  end
end
