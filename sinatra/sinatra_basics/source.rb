require 'sinatra'

# In sinatra, a route is an HTTP method paired with a URL-matching pattern
# Each route is associated with a block...

# Routes are matched in the order they are defined
# The first route that matches the request is invoked
get '/' do
	# .. show something ..
end

post '/' do
	# .. create something ..
end

put '/' do
	# .. replace something ..
end

patch '/' do
	# .. modify something ..
end

delete '/' do
	# .. annihilate something ..
end

options '/' do
	# .. appease something ..
end

link '/' do
	# .. affiliate something ..
end

unlink '/' do
	# .. separate something ..
end

# Route patterns may include named parameters, accessible via the params hash
get '/hello/:name' do
	"Hello #{params[:name]}!"
end

# You can also access named parameters via block parameters
get '/bye/:name' do |n|
	"Bye #{n}!"
end

# Route patterns may also include splat (or wildcard) parameters
# accessible via the params[:splat] array
get '/say/*/to/*' do
	params[:splat] # => [..., ...]
end

# Or with block parameters...
get '/download/*.*' do |path,ext|
	"Downloading file #{path}.#{ext}"
end

# Route patterns may also have optional parameters
get '/posts.?:format?' do
	"The format is #{params[:format] || "None"}"
end	

# Routes may also utilize query parameters
get '/book' do
		# matches GET /posts?title=foo&author=bar
		title = params[:title] || "No title"
		author = params[:author] || "No author"
		[title, author]
end

# CONDITIONS GO HERE
# I DONT UNDERSTAND THEM
# ......................

# Custom route matchers
# You can define your own route matchers
# class AllButtPattern
# 	Match = Struct.new(:captures)
# 	
# 	def initialize(except)
# 		@except, @captures = except, Match.new([])
# 	end
# 	
# 	def match(str)
# 		@captures unless @except === str
# 	end
# 	
# 	def all_but(pattern)
# 		AllButPattern.new(pattern)
# 	end
# 	
# 	get all_but("/index") do
# 		#...	
# 	end
# end

# Static files are served from the /public directory
# You can specify a different directory
set :public_folder, Dir.pwd + '/static'















	
	
	
	