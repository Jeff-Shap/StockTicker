#tickerv3.rb

require 'csv'
require 'open-uri'
require 'httparty'
require 'nokogiri'


module Symbols

	def import_symbols
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

	def stock_info(sym)

		if $symbols.include?(sym)
			 sym = sym.downcase
			 stock_data = HTTParty.get("http://finance.yahoo.com/q?s=#{sym}")
			 first = Nokogiri::HTML(stock_data.body)
			 stock_data = []
			 stock_data << first.xpath("//span[@id='yfs_l84_#{sym}']").first.content
			 stock_data << first.xpath("//span[@id='yfs_c63_#{sym}']").first.content
			 stock_data << first.xpath("//span[@id='yfs_p43_#{sym}']").first.content
			 price_data = first.xpath("//div/table[@id='table1']")
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']").first.content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[1].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[2].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[3].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[4].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[7].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[8].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[9].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[10].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[11].content
			 stock_data << price_data.xpath("//td[@class='yfnc_tabledata1']")[14].content
			 $stock_data = stock_data
		else 
			puts "INVALID STOCK SYMBOL"
		end
		# return $stock_data
	end
end

include Symbols
# import_symbols
# stock_info("AAPL")
# $stock_data


