class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url, notice: "ログインしました。"
    else
      flash.now[:danger] = "メールアドレスかパスワードが間違っています。"
      render 'sessions/new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: "ログアウトしました。"
  end

end
