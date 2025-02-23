class ApplicationController < Sinatra::Base
 ## register Sinatra::ActiveRecordExtension
 #set :views, Proc.new { File.join(root, "../views/") }
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end 

  get '/recipes' do
    @recipes = Recipe.all
    erb :index 
  end 

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end 

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    # @recipe = Recipe.find(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    erb :edit
  end 
  
  patch '/recipes/:id' do 
      @recipe = Recipe.find(params[:id])
      @recipe.name = params[:name]
      @recipe.ingredients = params[:ingredients]
      @recipe.cook_time = params[:cook_time]
      @recipe.save
      redirect to "/recipes/#{@recipe.id}"
  end 

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
#   -or-
#     @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end 

  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    # Recipe.destroy(params[:id])
    redirect to '/recipes'
  end 

end