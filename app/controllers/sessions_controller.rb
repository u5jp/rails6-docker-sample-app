class SessionsController < ApplicationController
  def new
  end

  #POST /login
  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #Success
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      #Failure
      # alert-danger => 赤色のフラッシュ
      flash.now[:danger] = 'Invalid email/password combination' # 本当は正しくない
      render 'new'
      # redirect_to vs. render
      # GET /user/1 => show template
      #                render 'new'(0回)
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
