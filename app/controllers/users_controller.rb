class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :destroy]
  before_action :correct_user,   only:[:edit, :update, :destroy]
  before_action :admin_check,    only:[:index]
  before_action :store_location, only:[:show]

  def index
    @users = User.order(:created_at)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, notice: "ユーザー登録に成功しました。"
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
      redirect_to @user, notice: "ユーザー情報を更新しました。"
    else  
      render 'users/edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = "ユーザー「#{user.name}」を削除しました。"
    if logged_in?
      redirect_to users_path
    else
      redirect_to root_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user) || current_user.admin?
    end

    def admin_check
      if !logged_in? || !current_user.admin?
        redirect_to root_url
      end
    end

end
