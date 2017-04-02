class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password])
      flash[:success] = 'You logged in'
      redirect_to root_path
    else
      @user = User.new
      flash.now[:danger] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = 'See you later!'
    redirect_to root_path
  end
end
