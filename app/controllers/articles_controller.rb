class ArticlesController < ApplicationController
  def index
    @articles = Article.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to root_url, notice: "記事を投稿しました。"
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
      redirect_to root_url, notice: "記事を更新しました。"
    else
      render 'articles/edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to root_url, notice: "記事を削除しました。"
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end
end
