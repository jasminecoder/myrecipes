class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    def new 
        @recipe = Recipe.new
        @recipes = Recipe.all
    end

    def create 
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = Chef.first
        if @recipe.save
            flash[:success] = "Recipe was created"
            redirect_to recipe_path(@recipe)
        else
            flash[:danger] = "error"
            render 'new'
        end
    end

    private
    def recipe_params
        params.require(:recipe).permit(:name, :description)
    end
end