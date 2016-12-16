require 'sinatra'
require 'data_mapper'

# Set up the database
DataMapper.setup(:default, "sqlite://#{Dir.pwd}/three.db")

# Define the user class
class User
  include DataMapper::Resource
    
  property :id, Serial
  
  property :username, String
  property :password, String  
    
  has n, :useruploads
  has n, :uploads, :through => :useruploads
end

# Define the uploaded file class
class Upload
  include DataMapper::Resource
  
  property :id, Serial
  
  property :name, String
  property :date_uploaded, DateTime
  
  has n, :useruploads
  has n, :users, :through => :useruploads
end

# Define the user-upload relationship
class Userupload
  include DataMapper::Resource
  
  property :id, Serial
  
  belongs_to :user, :key => true
  belongs_to :upload, :key => true
end

# Finalize the database
DataMapper.finalize.auto_upgrade!

get '/' do
  @users = User.all  
  erb :index
end

get '/uploads' do
  @uploads = Upload.all
  erb :uploads
end

get '/uploads/:upload' do
  @upload = Upload.first(:name => params[:upload])
  @upload.name
end


get '/register/:username/:password' do
  User.create(
    :username => params[:username],
    :password => params[:password]
  )
  redirect to '/'
end

get '/upload/:username/:password/:content' do
  user = User.first(
    :username => params[:username],
    :password => params[:password]
  )
  
  upload = Upload.new
  upload.name, upload.date_uploaded = params[:content], Time.now
  
  user.uploads.push(upload)
  user.save
  
  redirect to '/'
end