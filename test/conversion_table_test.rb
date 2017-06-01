require "minitest/autorun"
require_relative "../lib/conversion_table"

describe ConversionTable do
  it "validates nested parentheses" do
    assert ConversionTable.new("()").valid?
    refute ConversionTable.new("(()").valid?
    refute ConversionTable.new("(()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()").valid?
    assert ConversionTable.new("()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()").valid?
    refute ConversionTable.new("(hectare/second))").valid?
  end

  it "validates terms" do
    refute ConversionTable.new("(spaghetti/minute)").valid?
    refute ConversionTable.new("(minute/yep)").valid?
    assert ConversionTable.new("(hectare/second)").valid?
    assert ConversionTable.new("(°/second)").valid?
    assert ConversionTable.new("(degree/second)").valid?
  end

  it "raises an error converting invalid units" do
    assert_raises(ArgumentError) do
      ConversionTable.new("baloney").converted_units
    end

    assert_raises(ArgumentError) do
      ConversionTable.new("baloney/minutes").converted_units
    end

    assert_raises(ArgumentError) do
      ConversionTable.new("baloney").converted_multiplication_factor
    end

    assert_raises(ArgumentError) do
      ConversionTable.new("baloney/minutes").converted_multiplication_factor
    end    
  end

  it "converts units" do
    assert_equal "s", ConversionTable.new("minute").converted_units
    assert_equal "(m^2/s*s)", ConversionTable.new("(hectare/hour*d)").converted_units
    assert_equal "m^2/s", ConversionTable.new("hectare/h").converted_units
    assert_equal "rad/s", ConversionTable.new("degree/d").converted_units
    assert_equal "rad/s", ConversionTable.new("°/d").converted_units

    ConversionTable::DATA.each do |item|
      assert_equal item[1][:conversion_unit], ConversionTable.new(item[0]).converted_units
    end

    ConversionTable::DATA.each do |outer|
      ConversionTable::DATA.each do |inner|
        assert_equal "#{outer[1][:conversion_unit]}/#{inner[1][:conversion_unit]}", ConversionTable.new("#{outer[0]}/#{inner[0]}").converted_units
      end
    end   

    assert_equal "s/(s)", ConversionTable.new("minute/(minute)").converted_units
    assert_equal "s/(s*s)", ConversionTable.new("minute/(minute*minute)").converted_units
  end

  it "converts multiplcation factor" do
    assert_equal 10000.0 / 3600.0, ConversionTable.new("hectare/h").converted_multiplication_factor

    ConversionTable::DATA.each do |item|
      assert_equal item[1][:factor], ConversionTable.new(item[0]).converted_multiplication_factor
    end    

    ConversionTable::DATA.each do |outer|
      ConversionTable::DATA.each do |inner|
        expected = outer[1][:factor] / inner[1][:factor]
        assert_equal expected, ConversionTable.new("#{outer[0]}/#{inner[0]}").converted_multiplication_factor
      end
    end 

    ConversionTable::DATA.each do |outer|
      ConversionTable::DATA.each do |inner|
        expected = outer[1][:factor] * inner[1][:factor]
        assert_equal expected, ConversionTable.new("#{outer[0]}*#{inner[0]}").converted_multiplication_factor
      end
    end           
  end
end