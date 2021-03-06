class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update, :destroy, :following, :followers]
  before_action :correct_user,    only: [:edit, :update, :destroy]
  before_action :admin_check,     only: [:index]
  before_action :test_user_check, only: [:edit, :update, :destroy]
  before_action :store_location,  only: [:show]

  def index
    @users = User.order(:created_at).page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.includes([:category])
    @user_articles_pages = @user_articles.page(params[:page]).per(6)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, notice: "ユーザー登録に成功しました"
    else
      render 'users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, notice: "ユーザー情報を更新しました"
    else
      render 'users/edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "ユーザー「#{user.name}」は削除されました"
      if current_user.admin?
        redirect_to users_path
      else
        redirect_to root_url
      end
    else
      redirect_to user, notice: "ユーザー情報の削除に失敗しました"
    end
  end

  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(20)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20)
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   :picture, :remove_picture)
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        redirect_to root_url, notice: "このURLにはアクセスできません"
      end
    end

    def admin_check
      if !logged_in? || !current_user.admin?
        redirect_to root_url, notice: "adminユーザーのみアクセス可能です"
      end
    end

    def test_user_check
      user = User.find(params[:id])
      if user.test_user? && !current_user.admin?
        redirect_to user, notice: "テストユーザーの情報は編集できません"
      end
    end
end
