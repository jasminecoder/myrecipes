class LikesController < ApplicationController
    before_action :require_user
    
    def create
      @recipe = Recipe.find(params[:recipe_id])
      @like = @recipe.likes.build(like_params)
      @like.chef = current_chef
      @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
      @comment = Comment.new
      if @like.save
        # render 'recipes/show'
        redirect_to recipe_path(@recipe)
        # ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      else
        flash[:danger] = "Like was not created"
        redirect_back(fallback_location: root_path)
      end
    end
    
    private
    
    def like_params
      params.require(:like).permit(:liked)
    end
    
  end



