module InfixToPostfix

  # Return an array of postfix order if the given si_string does not contain parenthesis
  # Ex: "degree*ha/minute" -> ["degree", "ha", "*" ,"minute", "/"]
  # Time: O(n), space: O(n), assume n is the length of si_string
  def infix_to_postfix_without_parenthesis
    result = [] # An array of postfix order
    operator = nil # Remember the last operator "*" or "/"
    i = 0 # index go from 0 to the length of si_string
    current = "" # Keep track of the current name of symbol

    while (i < @si_string.length)
      # Handles the case if the character is an operator
      if (@si_string[i] == "*" || @si_string[i] == "/")
        result << current
        result << operator if !operator.nil?
        operator = @si_string[i]
        current = "" # Reset the current to ""

      # skip if the character is a white space
      # Append the character to the current (name or symbol)
      elsif @si_string[i] != " "
        current += @si_string[i]
      end

      i += 1
    end

    result << current # append the last name of symbol to postfix array
    result << operator if !operator.nil? # append the last operator to postfix array
    result
  end
end
