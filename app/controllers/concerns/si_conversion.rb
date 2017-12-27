module SiConversion

  class SiUnitConversion

    attr_reader :si_string, :si_counter_part, :num_decimal

    def initialize(si_string="", num_decimal=14)
      @si_string = si_string
      @num_decimal = num_decimal
      @si_counter_part = Hash.new
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
