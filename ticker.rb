#ticker.rb

require 'sinatra'
enable 'sessions'

get "/" do 
	erb :stockinputform
end

post "/" do 
	load 'get_stock_info.rb'
	sym = params[:stock_symbol]
	@data = stock_info(sym)
	redirect ("/results")
end

get "/results" do
	@data.inspect
end

# get "/:sym" do 
# 	@arry.read
# end