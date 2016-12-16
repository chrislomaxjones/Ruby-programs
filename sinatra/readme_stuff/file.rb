require 'sinatra'

# Splat parameter
get '/say/*/to/*' do
  params[:splat].to_s
end

# Block parameters
get '/download/*.*' do |name,ext|
  name + "." + ext
end

# Route patterns may have optional parameters
get '/posts.?:format?' do
  "Hi, you want posts in #{params[:format]}"
end

# Can also be used with query strings
get '/hello' do
  # match to '/hello?name=foo&age=10'
  "Your name is #{params[:name]} and you are #{"a" if params[:age].to_i == 1} #{params[:age]} #{params[:age].to_i == 1 ? "year" : "years"} old"
end

get '/foo' do
  params[:agent]
end

# You could use Procs and lambdas remember
l = ->(){ "Hi" }
get('/swag', &l)