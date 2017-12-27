module SiEvaluator

  # Evaluate the postfix order and return a floating number.
  # ["degree", "ha", "*" ,"minute", "/"] --> 2.90888208665722
  # Time: O(n), space: O(1), Assume n is the length of postfix array (@expression)
  def evaluate_postfix
    nums = []
    while !@expression.empty?
      current = @expression.shift

      # Handles the case if the current character is an operator "*", or "/"
      if ["*", "/"].include?(current)
        next if nums.length == 1

        num2 = nums.pop
        num1 = nums.pop
        value = current == "*" ? num1 * num2 : num1 / num2
        nums << value
      else # if the current element is a number, then append to the nums stack
        nums << @si_counter_part[current][:factor]
      end
    end

    nums.pop.round(@num_decimal)
  end
end
