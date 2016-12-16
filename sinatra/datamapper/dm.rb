require 'data_mapper' # Requires all the adapter gems etc

# A sqlite3 connection to a persistent database
DataMapper::setup(:default, "sqlite://#{Dir.pwd}/database.db")

# The post model needs to be persistent, so include DataMapper::Resource
# Convention -> singular, not plural version
class Post
  include DataMapper::Resource
  
  has n, :comments
  
  property :id,         Serial    # An auto-increment int key
  property :title,      String    # A varchar type string, for short strings
  property :body,       Text      # A text block, for longer strings
  property :created_at, DateTime  # A DateTime, for any date you might like
end

class Comment
  include DataMapper::Resource
  
  belongs_to :post
  
  property :id,         Serial
  property :posted_by,  String
  property :email,      String
  property :url,        String
  property :body,       Text
end

class Category
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
end

DataMapper.finalize

# This will issue the necessary CREATE statements (DROPing the table first, if it exists) to
# define each storage according to their properties. After auto_migrate! has been run, the 
# database should be in a pristine state. All the tables will be empty and match the model 
# definitions
DataMapper.auto_migrate!

def new_post
  # Create a new resource
  @post = Post.create(
    :title => "My first DataMapper post",
    :body => "A lot of text.....",
    :created_at => Time.now
  )
  # or new gives you it back unsaved, for more operations
  @post = Post.new(:title => "Butts")
  @post.body, @post.created_at = "A lot of text...", Time.now
  @post.save # Persist the resource
end

# Create n sample posts
def create_samples(n)
  n.times do |i|
    Post.create(title: "New Post #{i}", body: "Body of post #{i}", created_at: Time.now)
  end
end

def load_posts
  Post.all.each do |post|
    puts "", post.title, post.created_at, "-----", post.body
  end
end

create_samples(10)
load_posts