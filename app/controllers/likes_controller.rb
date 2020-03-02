class LikesController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    liked = current_user.likes.build(article_id: params[:article_id])
    liked.save
  end

  def destroy
    @article = Article.find(params[:article_id])
    liked = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
    liked.destroy
  end
end
