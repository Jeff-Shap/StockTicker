#ticker.rb

require 'sinatra'
enable 'sessions'

get "/" do 
	erb :stockinputform
end

post "/" do 
	load 'get_stock_info.rb'
	$sym = params[:stock_symbol]
	session[:data] = stock_info($sym)
	redirect ("/stock_info_#{$sym}")
end

get "/stock_info_#{$sym}" do 
	"<html><body>#{session[:data]}</body></html>"
end