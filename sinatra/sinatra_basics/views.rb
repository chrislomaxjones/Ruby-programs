require 'sinatra'

# This renders views/index.erb
get '/' do
	erb :index
end

# You can pass template content directly
get '/' do
	code = "<%= Time.now %>"
	erb code
end

# Templates take a second arg, the options hash
# This will render views/index.erb embedded in views/post.erb
get '/' do
	erb :index, :layout => :post
end

# Available options
# - Locals
#			-	List of locals passed to the document
#			- :locals => {:foo => "bar"} <%= foo %>
# - views
#			- Views folder to load templates from. 
#			- Default = settings.views
# - layout
#			-	Whether to use layout (true or false)
#			- If symbol, specifies the template to use
#	-	content_type
#			-	Content-Type the template produces
#	- scope
#			- Defaults to the application instance. 
#			- If you change this, instance variables
#				and helper methods will not be available.
# - layout_engine
#			- template engine used for the layout
# - layout_options
#			-	Special options only used for rendering the layout

# To change the views directory
set :views, settings.root + '/templates'


