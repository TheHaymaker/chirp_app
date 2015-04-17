require 'bundler'
Bundler.require()

ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:database => 'chirp_app',
	:host => 'localhost'
	)

require './models/chirp'
require './models/user'


get '/api/users' do 
	content_type :json
	User.all.to_json
end

get '/api/users/:id' do 
	content_type :json
	User.find(params[:id].to_i).to_json
end

post '/api/users' do 
	content_type :json
	User.create(params[:user]).to_json
end

put '/api/users/:id' do 
	content_type :json
	user = User.find(params[:id].to_i)
	user.update(params[:user]).to_json
end

patch '/api/users/:id' do 
	content_type :json
	user = User.find(params[:id].to_i)
	user.update(params[:user]).to_json
end

delete '/api/users/:id' do 
	content_type :json
	user = User.delete(params[:id].to_i)
	{message: "Success"}.to_json
end

get '/api/users/:user_id/chirps' do 
	content_type :json
	user = User.find(params[:user_id].to_i)
	user.chirps.to_json
end

get '/api/users/:user_id/chirps/:id' do 
	content_type :json
	user = User.find(params[:user_id].to_i)
	chirps = user.chirps
	chirp = chirps.find(params[:id].to_i)
	chirp.to_json
end

post '/api/users/:user_id/chirps' do 
	content_type :json
	user = User.find(params[:user_id].to_i)
	new_chirp = Chirp.new(params[:chirp])
	chirps = user.chirps
	chirps << new_chirp
	new_chirp.to_json
end

put '/api/users/:user_id/chirps/:id' do 
	content_type :json
	user = User.find(params[:user_id].to_i)
	chirps = user.chirps
	chirp = chirps.find(params[:id].to_i)
	chirp.update(params[:chirp]).to_json
end

patch '/api/users/:user_id/chirps/:id' do 
	content_type :json
	user = User.find(params[:user_id].to_i)
	chirps = user.chirps
	chirp = chirps.find(params[:id].to_i)
	chirp.update(params[:chirp]).to_json
end

delete '/api/users/:user_id/chirps/:id' do 
	content_type :json
	user = User.find(params[:user_id].to_i)
	chirps = user.chirps
	chirps.delete(params[:id].to_i)
	{message: 'Success...no more chirp_chirp :( ..'}.to_json
end

