#ImportSymbols.rb

require 'csv'
require 'open-uri'


module ImportSymbols
	options_hash = {:row_sep => "\r\n"}
	csv = open("http://www.nasdaq.com/screening/companies-by-name.aspx?letter=0&exchange=nasdaq&render=download")
	array = CSV.parse(csv)
	symbols = []
	array.each do |x|
		symbols << x[0]
	end
	symbols.delete_at(0)
	$symbols = symbols.sort
end