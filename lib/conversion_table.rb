# Handles converting between units
# @author [patrickveverka]
class ConversionTable
  DATA = {
    "minute"  => { factor: 60.0, conversion_unit: "s" },
    "hour"    => { factor: 3_600.0, conversion_unit: "s" },
    "day"     => { factor: 86_400.0, conversion_unit: "s" },
    "°"       => { factor: (Math::PI / 180.0), conversion_unit: "rad" },
    "degree"  => { factor: (Math::PI / 180.0), conversion_unit: "rad" },
    "'"       => { factor: (Math::PI / 10_800.0), conversion_unit: "rad" },
    "second"  => { factor: (Math::PI / 648_000.0), conversion_unit: "rad" },
    "\""      => { factor: (Math::PI / 648_000.0), conversion_unit: "rad" },
    "hectare" => { factor: 10_000.0, conversion_unit: "m^2" },
    "litre"   => { factor: 0.001, conversion_unit: "m^3" },
    "tonne"   => { factor: 1_000.0, conversion_unit: "kg" },
    "min"     => { factor: 60.0, conversion_unit: "s" },
    "h"       => { factor: 3_600.0, conversion_unit: "s" },
    "d"       => { factor: 86_400.0, conversion_unit: "s" },
    "ha"      => { factor: 10_000.0, conversion_unit: "m^2" },
    "L"       => { factor: 0.001, conversion_unit: "m^3" },
    "t"       => { factor: 1_000.0, conversion_unit: "kg" }
  }.freeze

  def initialize(units)
    @units = units
  end

  def converted_units
    raise ArgumentError, "Invalid Units" unless validate_terms

    iterate_items(:conversion_unit).join("")
  end

  def converted_multiplication_factor
    raise ArgumentError, "Invalid Units" unless validate_terms
    
    eval(iterate_items(:factor).join("")).to_f
  end

  def valid?
    validate_nested_parentheses && validate_terms
  end

  private

  def iterate_items(key)
    @units.split(/(\*|\/)/).map do |term|
      if term.match(/\((.*)\)/)
        "(" + DATA[Regexp.last_match[1]][key] + ")"
      elsif term =~ /\(/
        "(" + DATA[term.gsub(/\(|\)/, "")][key]
      elsif term =~ /\)/
        DATA[term.gsub(/\(|\)/, "")][key] + ")"
      elsif term =~ /(\*|\/)/
        term
      else
        DATA[term][key]
      end
    end
  end

  def validate_terms
    invalid = @units.gsub(/\(|\)/, "").split(/\*|\//).reject do |term|
      DATA.keys.include?(term)
    end

    invalid.count.zero?
  end

  def validate_nested_parentheses
    return false if @units.length < 2
    stack = []
    @units.each_char do |char|
      case char
      when '('
        stack.push(char)
      when ')'
        return false if stack.empty?
        stack.pop
      end
    end
    stack.empty?
  end
end
