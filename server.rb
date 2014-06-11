require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

# require all of the models and view templates
Dir['app/**/*.rb'].each { |file| require_relative file }

# set views directory to app/views
set :views, 'app/views'

get '/articles' do
  @articles = Article.order('created_at DESC')
  erb :'articles/index'
end
