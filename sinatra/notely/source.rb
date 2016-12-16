require 'sinatra'
require 'sinatra/cookies'
require 'data_mapper'
require 'securerandom'

# Setup the database
DataMapper::setup(:default, "sqlite://#{Dir.pwd}/notes.db")

# Create the model
class Note
	include DataMapper::Resource
	
	property :id, Serial
	property :url, String, :required => true
	property :contents, Text, :required => true, :lazy => false
end

# Finalize and upgrade the database
DataMapper.finalize.auto_upgrade!

# Root route
get '/' do
	cookies.to_s
end

get '/set/:oo' do
	cookies[:swag] = params[:oo]
	redirect to '/'
end

get '/get' do
	cookies[:swag]
end



# Generate a new note
#n = Note.new
#n.url = SecureRandom.hex[0..5]
#n.contents = "Your new note"
#n.save
#
#cookies[:saved_note] = n.url.to_s
#
#redirect "/#{n.url}"


get '/cookies' do
	cookies.to_s
end

get '/destroy' do
	Note.all.destroy
end

get '/:url' do
	@note = Note.first(:url => params[:url])
	@message = params[:message] || ""
	erb :index
end

put '/:url' do
	n = Note.first(:url => params[:url])
	n.contents = params[:contents]
	n.save
	
	redirect "/#{n.url}?message=saved."
end

delete '/:url' do
	n = Note.first(:url => params[:url])
	n.destroy
	
	"Destroyed successfully."
end









