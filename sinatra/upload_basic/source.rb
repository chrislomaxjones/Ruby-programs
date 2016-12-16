require 'sinatra'

get '/upload' do
  erb :upload
end

post '/upload' do
	File.open('uploads/' + params['myfile'][:filename], "w") do |f|
		f.write(params['myfile'][:tempfile].read)
	end
	"File successfully uploaded"
end

# CODE FROM THE WEBSITE...
#
#
# Handle POST-request (Receive and save the uploaded file)
##post "/upload" do 
##  File.open('uploads/' + params['myfile'][:filename], "w") do |f|
##    f.write(params['myfile'][:tempfile].read)
##  end
##  return "The file was successfully uploaded!"
##end
#
#
#