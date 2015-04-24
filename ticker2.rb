#ticker.rb

require 'sinatra'
enable 'sessions'
load 'get_stock_info.rb'
include Symbols

get "/" do 
	erb :stockinputform
end

post "/" do 
	load 'get_stock_info.rb'
	sym = params[:stock_symbol]
	redirect ("/results_#{sym}")
end

get "/results_:sym" do 
	import_symbols
	params[:data] = stock_info(params[:sym])
	erb :results
end

# get "/:sym" do 
# 	@arry.read
# end