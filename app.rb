require 'sinatra'

class PersonalDetailsApp < Sinatra::Base

	get '/' do
		erb :name
	end

	post '/name' do
		name = params[:name_input]
		redirect '/age?name=' + name
	end

	get '/age' do
		name = params[:name]
		

		# or erb :age, locals: {name: name}
		# or erb :age, :locals => {:name => name}
	end

	post /'age' do
		age = params[:age_input]
		name = params[:name]
		redirect '/fav_nums?age=' + age + '&name' + name
	# 	# redirect '/fav_nums?age=' + name
	end

	get '/fav_nums' do
		age = params[:age]
		name = params[:name]
		"#{name} and #{age}"
	end
end