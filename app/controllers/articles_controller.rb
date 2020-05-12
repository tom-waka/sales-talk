class ArticlesController < ApplicationController
  before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy, :feed]
  before_action :correct_article, only: [:edit, :update, :destroy]
  before_action :store_location,  only: [:index, :feed]
  before_action :can_not_delete,  only: [:destroy]

  def index
    @categories = Category.all
    @q = Article.includes([:user],[:category]).ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page]).per(6)
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
      redirect_to @article, notice: "記事を投稿しました"
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
      redirect_to @article, notice: "記事を更新しました"
    else
      render 'articles/edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to session[:forwarding_url] || root_url, notice: "記事を削除しました"
    session.delete(:forwarding_url)
  end

  def feed
    @articles = current_user.feed.includes([:user],[:category]).page(params[:page]).per(6)
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :category_id)
    end

    def correct_article
      article = Article.find(params[:id])
      redirect_to root_url, notice: "このURLにはアクセスできません" unless is_mine?(article) || current_user.admin?
    end

    def can_not_delete
      article = Article.find(params[:id])
      if article.user.test_user? && !current_user.admin?
        redirect_to request.referer, notice: "テストユーザーの投稿は削除できません"
      end
    end

end
