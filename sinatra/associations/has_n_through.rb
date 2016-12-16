require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/two.db")

class Photo
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  
  has n, :taggings
  has n, :tags, :through => :taggings
end

class Tag
  include DataMapper::Resource
  
  property :id, Serial
  property :content, String
  
  has n, :taggings
  has n, :photos, :through => :taggings
  endw

class Tagging
  include DataMapper::Resource
  
  belongs_to :tag, :key => true
  belongs_to :photo, :key => true
end

DataMapper.finalize.auto_upgrade!

get '/' do
  out = ""
  Photo.all.each do |photo|
    out << photo.name << "<br>"
    photo.tags.each do |tag|
      out << "<li>" << tag.content << "<br>"
    end
  end
  out
end

get '/addphoto/:name/:tags' do
  p = Photo.new
  p.name = params[:name]
  
  params[:tags].split(',').each do |split_tag|
    p.tags.push(Tag.create(:content => split_tag))
  end
  
  p.save
  
  redirect to '/'
end

get '/tag/:tag' do
  t = Tag.all(:content => params[:tag])
  out = ""

  t.photos.each do |photo|
    out << photo.name << "<br>"
  end
  
  out
end