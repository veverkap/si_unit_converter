require "sinatra"
require "oj"
require_relative "conversion_table"

get "/" do
  content_type :json
  Oj.dump(ConversionTable::DATA)
end

get "/units/si" do
  content_type :json
  table = ConversionTable.new(params[:units])
  if table.valid?
    Oj.dump(
      "unit_name"             => table.converted_units,
      "multiplication_factor" => table.converted_multiplication_factor
    )
  else
    Oj.dump(
      "error" => "Invalid Arguments"
    )
  end
end
