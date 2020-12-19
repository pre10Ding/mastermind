# frozen_string_literal: true

# mastermind feedback methods
module MastermindFeedback
  def provide_feedback(input, code, all_feedback)
    feedback = {
      match_pos: 0,
      match_color: 0,
      input: input,
      code: code
    }

    all_feedback << count_correct_pos_and_color(feedback) # count the number of correct pos
    puts "Number of correct characters in the correct position:   #{feedback[:match_pos]}"
    puts "Number of correct characters in the wrong position:     #{feedback[:match_color]}"
    print_guess_history
  end

  def count_correct_pos_and_color(feedback)
    code = feedback[:code].clone
    match_pos = 0
    feedback[:input].clone.each_with_index do |ele, index|
      next if ele != code[index]

      feedback[:code].delete_at(index - match_pos)
      feedback[:input].delete_at(index - match_pos)
      match_pos += 1
    end
    feedback[:match_pos] = match_pos
    count_correct_color(feedback) # returning this so that it can be tracked in @all_feedback
  end

  def count_correct_color(feedback)
    input = feedback[:input].clone
    match_color = 0
    input.each_with_index do |ele, index|
      next unless feedback[:code].include?(ele)

      feedback[:input].delete_at(index - match_color)
      feedback[:code].delete_at(feedback[:code].index(ele))
      match_color += 1
    end
    feedback[:match_color] = match_color
    feedback # returning this so that it can be tracked in @all_feedback
  end
end
