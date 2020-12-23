# frozen_string_literal: true

require './mastermindFeedback'
# computer class for AI activities
class Computer
  # MastermindFeedback is needed to enable the optimal guessing algorithm
  include MastermindFeedback

  def initialize(difficulty = 'normal')
    @difficulty = difficulty
    @first_get = true
    @previous_inputs = []
  end

  # returns a randomly generated 4 letter string composed of letters in valid_colors
  def get_input(_question_to_display, valid_characters, length, feedback = nil)
    # if the call didnt include feedback, make up the code. If it's provided then make some guesses
    return make_code(valid_characters, length) if feedback.nil?

    if @first_get
      populate_all_guesses(valid_characters, length) # make a list of all possible answers
      @first_get = false
    end
    get_guess(feedback)
  end

  def reset
    @previous_inputs = []
    @first_get = true
  end

  private

  # make a list of all possible answers
  def populate_all_guesses(valid_characters, length)
    @all_guesses = valid_characters.repeated_permutation(length).to_a.map!(&:join)
  end

  # make up a random code based on specified chars and length
  def make_code(valid_characters, length)
    code = []
    length.times { code << valid_characters[rand(valid_characters.length)] }
    @previous_inputs << code.join
    @previous_inputs.last
  end

  # use a rand value(make_code) instead of the optimal initial guess of AABB
  def get_guess(feedback)
    # loop @all_guesses and get feedback for them
    @all_guesses.select! do |ele|
      feedback_on_ele = provide_feedback(ele, @previous_inputs.last)
      # if feedback != matched, delete from @all_guesses
      feedback == [feedback_on_ele[:match_pos], feedback_on_ele[:match_color]]
    end
    # wait and display "processing" to user
    p '***************** Processing feedback ********************'
    sleep(1)
    p '***************** Generating new guess *******************'
    sleep(1)
    @previous_inputs << @all_guesses.first
    @previous_inputs.last
  end
end
