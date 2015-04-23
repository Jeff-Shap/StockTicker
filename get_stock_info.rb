#tickerv3.rb

require './ImportSymbols.rb'
include ImportSymbols

require 'HTTParty'
require 'nokogiri'


#sym = "MSFT"

#upcase for checking, downcase for method


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
else puts "NO SUCH SYMBOL FOUND"
end




