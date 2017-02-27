require 'minitest/autorun'
require 'rack/test'
require_relative '../app.rb'

class TestApp < Minitest::Test
	include Rack::Test::Methods

	def app
		PersonalDetailsApp

	end

	def test_ask_name_on_entry_page
		get '/'
		assert(last_response.ok?)
		assert(last_response.body.include?("Hello, what is your name?"))
		assert(last_response.body.include?('<input type="text" name="name_input">'))
		assert(last_response.body.include?('<form method="post" action="/name">'))
		
	end

	def test_post_to_name
		post '/name', name_input: 'April'
		follow_redirect!
		assert(last_response.body.include?('April'))
		assert(last_response.ok?)
	end


	def test_get_age
		get 'age?name=April'
		assert(last_response.body.include?('Hello, April! How old are you?'))
		assert(last_response.ok?)
		assert(last_response.body.include?("<input type='submit' value = 'Push It'>"))
	end

	def test_post_to_age
		post '/age', age_input: '39', name_input: 'April'
		follow_redirect!
		assert(last_response.body.include?('39'))
		assert(last_response.ok?)
	end

end