module SiConversion

  class SiUnitConversion
    include InfixToPostfix

    attr_reader :si_string, :si_counter_part, :num_decimal, :expression

    def initialize(si_string="", num_decimal=14)
      @si_string = si_string # params[:units]
      @num_decimal = num_decimal
      @expression = [] # Array of postfix expression
      @si_counter_part = Hash.new
    end


    def get_result
      get_post_fix_expression
      get_si_counter_part

      if !valid_si_string?
        return {
          error: "Invalid Input",
        }
      else
        return {
          unit_name: "A name",
          multiplication_factor: 7
        }
      end
    end

    # Return an array of postfix order
    # Time: O(n), space: O(n), assume n is the length of si_string
    def get_post_fix_expression
      if check_for_parenthesis
        @expression = infix_to_postfix_with_parenthesis
      else
        @expression = infix_to_postfix_without_parenthesis
      end
    end

    # Create si_counter_part with its keys as name and symbol,
    # and values as unit and factor.
    # Time: O(n), space: O(n), assume n is the length of si_string
    def get_si_counter_part
      @si_counter_part = si_unit_to_hash
    end

    # Check whether the given si_string contain a parenthesis
    # Time: O(n), space: O(1), assume n is the length of si_string
    def check_for_parenthesis
      @si_string =~ /\(/ ? true : false
    end

    # Check whether the given si_string is the valid input
    # Time: O(n), space: O(1), assume n is the length of si_string
    def valid_si_string?
      @expression.each do |str|
        next if ["*", "/"].include?(str)
        return false if (!@si_counter_part[str])
      end
      true
    end

    private
    # Create a hash with its keys as name and symbol,
    # and values as unit and factor
    # hash = {
    #  "min": { unit: "s", factor: 60 },
    #  "tonne": { unit: "kg", factor: 1000 },
    #  ...
    # }
    def si_unit_to_hash
      hash = Hash.new
      SiNameSymbol.all.each do |name_symbol|
        name = name_symbol.name
        symbol = name_symbol.symbol

        unit = name_symbol.si_unit.unit
        factor = name_symbol.si_unit.factor
        value = { unit: unit, factor: factor }

        hash[name] = value if !name.nil?
        hash[symbol] = value
      end
      hash
    end

  end
end
