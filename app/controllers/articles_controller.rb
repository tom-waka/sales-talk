class ArticlesController < ApplicationController
  before_action :logged_in_user, only:[:new, :create, :edit, :update, :destroy]
  before_action :store_location, only:[:index, :new]

  def index
    @articles = Article.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build if logged_in?
  end

  def create
    @article = current_user.articles.build(article_params)
    
    if @article.save
      redirect_to @article, notice: "記事を投稿しました。"
    else 
      render 'articles/new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: "記事を更新しました。"
    else
      render 'articles/edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to session[:forwarding_url] || root_url, notice: "記事を削除しました。"
    session.delete(:forwarding_url)
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end
end
