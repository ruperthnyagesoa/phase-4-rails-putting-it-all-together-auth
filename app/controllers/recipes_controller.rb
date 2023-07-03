class RecipesController < ApplicationController
    
    wrap_parameters format: []

    before_action :authorize


   def index 
        recipes = Recipe.all 
        render json: recipes, status: :created
   end

   def create

    recipe = Recipe.create(
        user_id: session[:user_id],
        title: params[:title],
        instructions: params[:instructions],
        minutes_to_complete: params[:minutes_to_complete]
    )

    if recipe.valid?

        render json: recipe, status: :created
    else 

        render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
    end
   end


   private 
   def authorize
    errors_method unless session.include? :user_id
   end


   def errors_method 
     user = User.new 
        user.validate
        render json: {errors: user.errors.full_messages}, status: :unauthorized
   end

end