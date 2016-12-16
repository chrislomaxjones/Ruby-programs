# Require necessary gems
require 'sinatra'
require 'data_mapper'
require 'SecureRandom'
require 'digest'

# Setup the database
DataMapper.setup(:default, "sqlite://#{Dir.pwd}/data.db")

# User model
class User
	include DataMapper::Resource

	# Important properties
	property :id, Serial
	property :username, String
	property :password_hash, String
	property :salt, String

	# Can also include other user properties
	property :created_at, DateTime
	property :email_address, String
end

# Finalize and create the db tables
DataMapper.finalize.auto_upgrade!

# Enable sessions for login-information
enable :sessions
set :session_secret, '*&(^B234'

# Module handles all Auth logic
module Authentication
	def authenticate?
		not session[:auth].nil?
	end

	def get_user_from_session
		# Check the user is authenticated
		if authenticate?
			# Return the first user with id that matches session id
			return User.first(:id => session[:auth])
		end
		# If execution reaches this point something went wrong
		# Return nil
		nil
	end
end

# Module handles all Encryption logic
module Encryption
	def encrypt(plain_text, salt="", pepper="")
		raise ArgumentError if plain_text.nil?

		# Compute and return a digest right here...
		# For now simply return the concatenation
		salt + pepper + plain_text
	end
end

# Include the modules above as helpers
helpers Authentication, Encryption

get '/' do
	erb :index	
end

before '/auth/*' do
	redirect to "/login#{request.path_info}" unless authenticate?
end

get '/auth/secret' do
	erb :secret
end

get '/auth/profile' do
	@user = get_user_from_session
	erb :profile
end

put '/auth/profile' do
	# Get the user from the session
	user = get_user_from_session

	# Check the password entered matches the user's
	if user.password_hash == encrypt(params[:old_password], user.salt)
		# Update the credentials
		user.username = params[:username]
		user.email_address = params[:email]
		user.password_hash = encrypt(params[:new_password], user.salt)

		if user.save
			redirect to '/auth/profile'
		end		
	end

	# Failure
	@user = user
	erb :profile, :locals => { update_message: "Failed to update account." }
end

delete '/auth/profile' do
	# Get the user from the session
	user = get_user_from_session 

	# Check the passwords match
	if user.password_hash == encrypt(params[:old_password], user.salt)
		# Destroy the user
		user.destroy
		# Set the session to nil
		session[:auth] = nil
		# Redirect home
		redirect to '/'
	end

	@user = user
	erb :profile, :locals => { delete_message: "Failed to delete account." }
end

get '/register' do
	erb :register
end

post '/register' do
	# Create new user
	user = User.new

	# Fill in the properties
	user.username = params[:username]
	user.email_address = params[:email]
	user.created_at = Time.now

	# Generate the user's salt
	salt = SecureRandom.hex(6)
	user.salt = salt

	# Generate the password
	user.password_hash = encrypt(params[:password], salt)

	# Check if user saves successfully or fails
	if user.save
		redirect to '/'
	else
		"failure"
	end
end

get '/login*' do
	@redirect_url = params[:splat][0]
	if @redirect_url != ""
		@is_redirected = true 
	else
		@is_redirected = false
	end
	erb :login, :locals => {message:nil}
end

post '/login*' do
	# Look for first user record matching username
	if user = User.first(:username => params[:username])
		# See if hashed password matches encrypted input + salt
		if user.password_hash == encrypt(params[:password], user.salt)
			# Set the auth session on user's machine to true
			session[:auth] = user.id

			# If no redirect-url was supplied
			if params[:splat][0] != ""
				redirect to params[:splat][0]
			# Otherwise redirect home
			else
				redirect to '/'
			end
		end
	end

	# If execution reaches this point then login failed
	# Route to the login page w/ error message
	@redirect_url = params[:splat][0]
	if @redirect_url != ""
		@is_redirected = true 
	else
		@is_redirected = false
	end
	# Provide a message local variable
	erb :login, :locals => {message: "Failure to login. Please try again."}
end

get '/logout' do
	# Nil the session
	session[:auth] = nil
	# Redirect home
	redirect to '/'
end




