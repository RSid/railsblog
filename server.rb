require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'pry'

# require all of the models and view templates
Dir['app/**/*.rb'].each { |file| require_relative file }

# set views directory to app/views
set :views, 'app/views'

get '/articles' do
  @articles = Article.order('created_at DESC')
  erb :'articles/index'
end

get '/articles/new' do
  @categories = Category.all
  erb :'articles/new'
end

post '/articles' do
  @article = Article.new(author: params[:article][:author],
    title: params[:article][:title], body: params[:article][:body])

  if @article.save
    params[:category].each do |category_id|
      category = Category.find(category_id)
      Categorization.create(article: @article,
        category: category)
    end

    redirect '/articles'
  else
    flash.now[:notice] = "Uh oh! Your blog post could not be saved."
    erb :'articles/new'
  end
end

get '/articles/:id' do
  @article = Article.find(params[:id])
  erb :'articles/show'
end

post '/articles/:article_id/comments' do
  @article = Article.find(params[:article_id])
  @comment = Comment.new(body: params[:body],
    author: params[:author], article: @article)

  if @comment.save
    redirect "/articles/#{@article.id}"
  else
    flash.now[:notice] = "Uh oh!  Could not post your comment."
    erb :'articles/show'
  end
end
