require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/database.db")

# has n and belongs_to (or One-To-Many)
class Post
  include DataMapper::Resource
  
  property :id, Serial
  property :contents, String
  
  has n, :comments
end

class Comment
  include DataMapper::Resource
  
  property :id, Serial
  property :rating, Integer
  
  belongs_to :post # defaults to :required => true
  
  def self.popular
    all(:rating.gt => 3)
  end
end

DataMapper.finalize.auto_upgrade!

get '/' do
  p = Post.all :order => :id.desc
  
  out = ""
  
  p.each do |p|
    out << p.contents << "<br>"
    if p.comments.length == 0
      out << "<li>" << "No comments" << "<br>"
    else
      p.comments.each do |c|
        out << "<li>" << c.rating.to_s << "<br>"
      end
    end
  end
  
  out
end

get '/addpost/:contents' do
  Post.create(:contents => params[:contents])
  redirect to('/')
end

get '/addcomment/:postid/:rating' do
  p = Post.first :id => params[:postid]
  
  p.comments.push Comment.create(:rating => params[:rating])
  p.save
  redirect to('/')
end
