# You declare the properties for a model inside its class definition
# which is then used to generate the fields in the data-store

# Advantages
# => Properties are documented in the model, not a migration or XML file
# => It lets you limit the properties using Ruby's access semantics
#   => They can be declared public (default), protected or private 
# => Since DataMapper only cares about properties explicity defined in models
#    DataMapper works well with legacy data-stores and shares them easily
#    with other applications.

require 'data_mapper'
DataMapper::setup(:default, "sqlite://#{Dir.pwd}/properties.db")

# Declaring properties
#---------------------
#   Call the property method for each property you want to add
#   The only two required arguments are name and type
class Post
  include DataMapper::Resource
  
  property :id,         Serial                      # Primary serial key
  property :title,      String,  :required => true  # Cannot be nil
  property :published,  Boolean, :default => false  # New records default value is false
end

# Keys
#---------------------
# Primary keys
# => Not automatically created for you
# => One key property must be configured
# => DataMapper has a shortcut for an auto-incrementing integer
#    as a primary key - Serial class

# Natural Keys
# => Anything can be a key. Pass :key => true as an option during property
#    defintion
# => Natural keys are protected again mass assignment, so their setter= method
#    will need to be called individually if you're looking for them
# (Don't use boolean, Discriminator, and time related types)
class Model
  include DataMapper::Resource
  property :slug, String, :key => true # any type here
end

# Composite keys
# => You can have more than 1 property in the primary key
class Comment
  include DataMapper::Resource
  
  property :old_id, Integer, :key => true
  property :new_id, Integer, :key => true
end

# Setting Default Values
#-------------------------------
# Defaults can be set via the :default property
# => These can be static values, e.g. 12 or "hello"
# => DataMapper offers the ability to use a Proc to set the default value
# => The property becomes whatever the Proc returns, which will be
#    the first time the property is used without having first set a value
# => The Proc recieves 2 arguments - the resource its being set on, and the
#    property itself
class SomeModel
  include DataMapper::Resource
  
  property :id,       Serial
  property :name,     String, :required => true, :default => "John Johnson"
  property :greeting, String, :default => ->(r,p){ "Hello there #{r.name}"}
end

john = SomeModel.new
puts john.name     # => "John Johnson"
puts john.greeting # => "Hello there John Johnson"

# Setting Default Options
#-----------------------------------
# You can specify default options once and have them applied to all properties
# that you add to your models
# These options are overrided by specifying any option explicitly when defining
# a specific property

# set all String properties to have a default length of 255
DataMapper::Property::String.length 255

# set all Boolean properties to not allow nil (force true/false)
DataMapper::Property::Boolean.allow_nil false

# set all properties to be required by default
DataMapper::Property.required true

# set all mutator methods to be private by default
DataMapper::Property.writer(:private)

# Lazy Loading
#------------------------------------------------------------------------------
# => A lazily loaded property is not requested from the data-store by default
# => Instead, it is only loaded when its accessor is called for the first time
# => This means you can stop default queries from being greedy, a paticular
#    problem with text fields. Text fields are lazily loaded by default, which
#    can be overrided.
class UmModel
  include DataMapper::Resource
  
  property :id,     Serial
  property :title,  String
  property :body,   Text    # Lazily loaded by default
  property :count,  Integer, :lazy => false
end

# Lazily loaded properties can be grouped together by context
# this is so if one is fetched, all the associated ones will be as well
# cutting down on trips to the data-store
class MmmModel
	include DataMapper::Resource

	property :id,     Serial
	property :title,  String
	property :subtitle, String,   :lazy => [:load_together]
	property :body,     String,   :lazy => [:load_together]
	property :views,    Integer,  :lazy => [:load_together]
end

# Limiting Access
#------------------------------------------------------------------------------
# Access for properties is defined using the same semantics as Ruby.
# Accessors are public by default, but you can declare them as private
# or protected if necessary.
# Can be set using the accessor option
class Book
	include DataMapper::Resource
	
	property :title, String     # Default public accessor

	property :pages, Integer, :accessor => :private # Reader + Writer Private
	property :published_at, DateTime, :accessor => :protected # Reader + Writer protected

	property :first_page, Text, :writer => :private # Only writer is private
	property :borrower, String, :reader => :protected # Only reader is protected
end

# Over-riding access
# You can override the accessors as you would in a normal ruby class
class AnotherModel
	include DataMapper::Resource
	
	property :slug, String
	
	def slug=(new_slug)
		raise ArgumentError if new_slog != 'DataMapper is Awesome'
		super # Use original method instead of accessing @ivar directly
	end
end














