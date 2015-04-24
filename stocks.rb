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
	sym = params[:sym]
	params[:data] = stock_info(params[:sym])
	if params[:data] == nil
		redirect("/error_#{sym}.html")
	else
		erb :results
	end
end

get "/error_:sym.html" do
	erb :error
end
# get "/error_:sym.html" do 
#  "hello"
# end


# get "/:sym" do 
# 	@arry.read
# end