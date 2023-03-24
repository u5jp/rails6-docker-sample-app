class UsersController < ApplicationController
  #Get /users/:id
  def show
    @user = User.find(params[:id])
  end

  #Get /users/new
  def new
    @user = User.new
  end

  def create
    # (@user + given params).save
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # Success(valid params))
      # GET "/users/#{user.id}"
      redirect_to @user
      # redirect_to user_path(@user)
      # redirect_to user_path(@user.id)
      # redirect_to user_path(1)
      # => /users/1
    else
      # Failure(not valid params)
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
