class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @article = Article.find(params[:article_id])
    liked = current_user.likes.build(article_id: params[:article_id])
    liked.save
    @article.reload
  end

  def destroy
    @article = Article.find(params[:article_id])
    liked = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
    liked.destroy
    @article.reload
  end
end
