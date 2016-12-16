require 'sinatra'
require 'data_mapper'

# Set up the database
DataMapper.setup(:default, "sqlite://#{Dir.pwd}/database.db")

class Coffee
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :price, Decimal
  property :size, Integer
  
  has n, :coffeeflavours
  has n, :flavours, :through => :coffeeflavours
end

class Flavour
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :contains_nuts, Boolean, :default => true

  has n, :coffeeflavours
  has n, :coffees, :through => :coffeeflavours
end

class Coffeeflavour
  include DataMapper::Resource
  
  belongs_to :coffee, :key => true
  belongs_to :flavour, :key => true
end

# Create tables
DataMapper.finalize.auto_upgrade!

get '/' do
  @coffees = Coffee.all
  erb :index
end

get '/coffee/add' do
  erb :add_coffee
end

post '/coffee/add' do
  coffee = Coffee.new
  
  # Add the coffee properties
  coffee.name = params[:name]
  coffee.size = params[:size]
  coffee.price = params[:price]
  
  # Add the flavours
  flavours = []
  
  3.times do |i|
    # Attempt to find an existing flavour
    f = Flavour.first(:name => params[:"flavour-name-#{i}"]) 
    
    # Otherwise create a new flavour if nil
    if f.nil?    
      f = Flavour.create(
        :name => params[:"flavour-name-#{i}"], 
        :contains_nuts => (params[:"flavour-contains-nuts-#{i}"] == "on")
      )
    end
    # Push the flavour to the flavours array of coffee instance
    coffee.flavours.push f
  end
  
  # Save coffee and redirect appropriately
  if coffee.save
    redirect to '/'
  else
    redirect to '/coffee/add'
  end
end

# Backdoor method destroys everything...
get '/delete' do
  Coffee.all.destroy
  Flavour.all.destroy
end


get '/flavour/search' do
  @flavours = Flavour.all(:order => :id.desc)
  erb :flavours_search
end