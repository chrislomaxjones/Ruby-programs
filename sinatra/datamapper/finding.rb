require 'data_mapper'
DataMapper::setup(:default, "sqlite:://#{Dir.pwd}/finding.db")

class Zoo
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :description, Text
  property :inception, DateTime
  property :open, Boolean, :default => false
  property :age, Integer
end

DataMapper.finalize.auto_upgrade!

# Finder Methods
#---------------
# DataMapper has method which allow you to grab a single record by key,
# the first match to a set of conditions,
# or a collection of records matching conditions
zoo = Zoo.get(1)    # Get the zoo with primary key of 1
zoo = Zoo.get!(1)   # get! if you want ObjectNotFoundError on failure
zoo = Zoo.get('DWF') # wow, support for natural primary keys
zoo = Zoo.get('METRO', 'DWF') # composite key look-up
zoo = Zoo.first(:name => 'Metro') # first matching record with name 'Metro'
zoo = Zoo.last(:name => 'Metro') # last matching record with name 'Metro'
zoo = Zoo.all # All zoos
zoo.all(:open => true) # All zoos that are open
zoo.all(:age => (1..10)) # All zoos less than 10 years old

# Scopes and Chaining
#--------------------
all_zoos = Zoo.all
open_zoos = all_zoos.all(:open => true)
big_open_zoos = open_zoos.all(:animal_count => 1000)

# As a direct consequence, you can define scopes without any extra work in your model
class Zoo
  def self.open
    all(:open => true)
  end
  
  def self.big
    all(:animal_count => 1000)
  end
end

big_open_zoos = Zoo.big.open

# Conditions
#-----------
# Clever additions to symbol class allow for complex conditions
exhibitions = Exhibitionall(:run_time.gt => 2, :run_time.lt => 5)
# => SQL conditions: 'run_time > 2 AND run_time < 5'

# Valid symbol operators
# => gt - greater than
# => lt - less than
# => gte - great than or equal to
# => lte - less than or equal to
# => not - not equal
# => eql - not equal
# => like - like