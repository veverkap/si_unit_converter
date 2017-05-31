require "sinatra"
require "./conversion_table"

get "/" do
  a = ConversionTable.new
  puts ConversionTable::DATA
  "Hello World!"
end
