require 'sinatra'
require 'data_mapper'

# Mimics a production environment
# Disables the sinatra errors
# So you can use your own
set :environment, :production

# Sqlite3 connection
DataMapper::setup(:default, "sqlite://#{Dir.pwd}/linker.db")

# Link model
class Link
    include DataMapper::Resource
    
    property :id,           Serial
    property :title,        String, :required => true
    property :url,          String, :required => true
    property :desc,         Text, :required => true
    property :created_at,   DateTime
    property :updated_at,   DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do  # View all links
    @links = Link.all :order => :updated_at.desc
    @title = "Saved links"
    erb :index
end

post '/' do  # Add a new link
    l = Link.new
    l.url = params[:url]
    l.title = params[:title]
    l.desc = params[:desc]
    l.created_at = Time.now
    l.updated_at = Time.now
    
    if l.save
        redirect '/'
    else
        raise
    end
end

put '/:id' do
    # Get the unchanged link
    l = Link.get params[:id]
    # Update properties
    l.url = params[:url]
    l.title = params[:title]
    l.desc = params[:desc]
    l.updated_at = Time.now
    
    if l.save
        redirect '/'
    else
        redirect '/error'
    end
end

get '/id/:id' do
    @link = Link.get params[:id]
    if @link
        @title = "#{@link.title}"
        erb :link
    else
        raise
    end
end

get '/edit/:id' do
    @link = Link.get params[:id]
    if @link
        @title = "Edit #{@link.title}"
        erb :edit
    else
        raise
    end
end

get '/delete/:id' do 
    @link = Link.get params[:id]
    if @link
        @title = "Delete #{@link.title}"
        erb :delete
    else
        raise
    end
end

delete '/:id' do
    l = Link.get params[:id]
    l.destroy
    redirect '/'
end

not_found do
    erb "Not found"
end

get '/error' do
    erb "Error"
end




