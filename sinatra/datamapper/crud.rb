require 'data_mapper'
DataMapper::setup(:default, "sqlite://#{Dir.pwd}/crud.db")

# Bang(!) or no bang methods
#---------------------------
# The main CRUD methods are .create, .save, .update, .destroy
# They all have bang method equivs (e.g. .create!) which operate in a different manner

# The safe non-bang methods will loaded all effected resources into memory and
# execute the callbacks on each one

# The bang methods will never execute all callbacks and validations. Greater performance

# Raising an exception when save fails
#-------------------------------------
# By default, datamapper returns true or false for all operations manipulating the
# persisted state of a resource (.create, .save, .update, .destroy)

# If you want it to raise exceptions instead, you can instruct datamapper to do so either
# globally, on a per model or per instance basis

DataMapper::Model.raise_on_save_failure = true # Globally across all models
#Zoo.raise_on_save_failure = true # per-model
#zoo.raise_on_save_failure = true # per-instance

# The Example Zoo
#----------------------

# We'll create, save update and destroy a record...
class Zoo
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :description, Text
  property :inception, DateTime
  property :open, Boolean, :default => false
end

DataMapper.finalize.auto_upgrade!

# We can use the create method to create a resource with given attributes
zoo = Zoo.create(:name => 'The Glue Factory', :inception => Time.now)

# If creation was successful, create will return the new resource
# If it failed, it will return a new resource that is initialized with given attribiutes
# with default values for that resourced, but is NOT saved.
# To find out whether the creation was successful or not, you can call .saved? on the
# returned resoure - returns true if persist successful

# If you want to find a Zoo instance with a given name, and if none is found, it will
# return a newly created Zoo with that name, use .first_or_create
zoo = Zoo.first_or_create(:name => 'The Glue Factory')

# We can also specify the inclusion of attributes which are NOT searched for
# For example...
zoo = Zoo.first_or_create({:name => 'The Glue Factory'}, {:inception => Time.now})
# This will search for the first record in the table with name 'The Glue Factory'
# It will NOT search for an inception date of now
# However, if none is found a new object is created with the name 'The Glue Factory'
# and the inception time of Time.now

# You can even ovveride properties in the second hash
zoo = Zoo.first_or_create({:name => 'The Glue Factory'}, {
  :name => 'London Zoo',
  :inception => Time.now
})

# Save
#-----
# We can also create a new instance of the model, update its properties and save it
# to the data-store. The call to save returns true with success and false with failure
zoo = Zoo.new
zoo.attributes = { :name => 'The Glue Factory', :inception => Time.now }
zoo.save

# We can use ruby accessors like a normal class
zoo = Zoo.new
zoo.name = 'The Glue Factory'
zoo.inception = Time.now
zoo.save

# Update
#------
# You can also update a model's properties and save it with one method call
# update will return true if the record saves and false if it fails, exactly like
# the save method
zoo.update(:name => 'London Zoo')

# update is also a class method which can be used to do mass updates
Zoo.update(:name => 'London Zoo')
# This sets all Zoo instances' name property to Lodon Zoo
# same as...
Zoo.all.update(:name => 'London Zoo')

# Destroy
#--------
# To destroy a record, call the .destroy method
# It will return true or false depending on if the record is successfully deleted or not
zoo = Zoo.get(1)
zoo.destroy # => true

# You can also call the class method
Zoo.destroy
# The same as...
Zoo.all.destroy