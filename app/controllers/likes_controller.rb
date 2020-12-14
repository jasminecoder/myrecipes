class LikesController < ApplicationController
    before_action :require_user
    
    def create
      @recipe = Recipe.find(params[:recipe_id])
      @like = @recipe.likes.where(chef_id: current_chef).first_or_initialize
      @old_liked = @like.liked      
      @like.attributes = like_params
      if @old_liked == @like.liked
        @like.destroy
      else
        success = @like.save
        flash[:danger] = "Like was not created" unless success
      end
      redirect_to recipe_path(@recipe)
    end
    
    private
    
    def like_params
      params.require(:like).permit(:liked)
    end
    
  end



