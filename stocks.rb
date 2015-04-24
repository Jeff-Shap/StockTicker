#ticker.rb

require 'sinatra'
configure { set :show_exceptions, false }
enable 'sessions'
load 'get_stock_info.rb'
include Symbols

get "/" do 
	erb :stockinputform
end

post "/" do 
	load 'get_stock_info.rb'
	sym = params[:stock_symbol].upcase
	redirect ("/results_#{sym}")
end

get "/results_:sym" do 
	import_symbols
	params[:data] = stock_info(params[:sym])
	if params[:data] == nil
		redirect("/error.html")
	else
		erb :results
	end
end

get "/error.html" do
	sleep(3)
	erb :stockinputform
end
# get "/error_:sym.html" do 
#  "hello"
# end


# get "/:sym" do 
# 	@arry.read
# end