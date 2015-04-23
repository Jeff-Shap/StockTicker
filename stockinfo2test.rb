# stockinfo2test.rb

#tickerv3.rb

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

include ImportSymbols

require 'HTTParty'
require 'nokogiri'


def stock_info(sym)

	if $symbols.include?(sym)
		 sym = sym.downcase
		 stock_data = HTTParty.get("http://finance.yahoo.com/q?s=#{sym}")
		 first = Nokogiri::HTML(stock_data.body)
		 stock_data = []
		 current_price = first.xpath("//span[@id='yfs_l84_#{sym}']").first.content
		 current_change = first.xpath("//span[@id='yfs_c63_#{sym}']").first.content
		 change_percent = first.xpath("//span[@id='yfs_p43_#{sym}']").first.content
		 price_data = first.xpath("//div/table[@id='table1']")
		 previous_close = price_data.xpath("//td[@class='yfnc_tabledata1']").first.content
		 open = price_data.xpath("//td[@class='yfnc_tabledata1']")[1].content
		 bid = price_data.xpath("//td[@class='yfnc_tabledata1']")[2].content
		 ask = price_data.xpath("//td[@class='yfnc_tabledata1']")[3].content
		 oneyr = price_data.xpath("//td[@class='yfnc_tabledata1']")[4].content
		 day_range = price_data.xpath("//td[@class='yfnc_tabledata1']")[7].content
		 year_range = price_data.xpath("//td[@class='yfnc_tabledata1']")[8].content
		 volume = price_data.xpath("//td[@class='yfnc_tabledata1']")[9].content
		 threemonth_avg_volume = price_data.xpath("//td[@class='yfnc_tabledata1']")[10].content
		 market_cap = price_data.xpath("//td[@class='yfnc_tabledata1']")[11].content
		 div_yield = price_data.xpath("//td[@class='yfnc_tabledata1']")[14].content
	else puts "NO SUCH SYMBOL FOUND...\n"
	end
end

stock_info("AAPL")