require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/cookies'

use Rack::Session::Cookie, 
    :key => 'rack.session',
    :path => '/',
    :expire_after => 2592000, # In seconds
    :secret => 'change_me'



get '/' do
	session['foo'] || "Foo not found"
end

get '/set/:val' do
	session['foo'] = params[:val]
	"Success!"
end