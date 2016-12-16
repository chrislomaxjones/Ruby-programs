require 'sinatra'
require 'data_mapper'
require 'dm-validations'


# Validations
#-------------

# Manual Validation
# We can call validation methods directly by passing them a property name to validate against

class Post
  include DataMapper::Resource
  
  property :id, Serial
  property :contents, Text
  property :date_posted, DateTime
  
  # Manual validation
  validates_length_of :post
end

# Below are the manual validations we can use
  # => validates_absence_of
  # => validates_acceptance_of
  # => validates_with_block
  # => validates_confirmation_of
  # => validates_format_of
  # => validates_length_of
  # => validates_with_method
  # => validates_numericality_of
  # => validates_primitive_type_of
  # => validates_presence_of
  # => validates_uniqueness_of
  # => validates_within


# Auto validations
# ...


# Error Messages
# You can change the error messages as an optional symbol
class Tag
  include DataMapper::Resource
  
  property :id, Serial
  
  # With manual validations
  property :pin, Integer, :length => 4
  validates_uniqueness_of :pin, :message => "This pin is already reserved"
  
  # With auto validations
  property :email, String, :required => true, :unique => true, :format => :email_address, :messages => {
    presence: "We need your email address.",
    is_unique: "We already have that email",
    :format: "Doesn't look like an email to me"
  }
end

# Custom validations can also be used
# Check this out
class Page
  include DataMapper::Resource
  
  # Properties...
  
  validates_with_method :content_check
  
  def content_check
    conditional = true
    if conditional # Have some sort of condition
      true
    else
      [false, "This is the error message"]
    end
  end
end

