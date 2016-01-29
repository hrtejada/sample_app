class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user #log_in in sesion helper
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #remember user #Uses session token to check if user is saved on browser
      redirect_back_or user #redirect used for path to user_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination' #Flash.now is for messages to be displayed and removed after new request is sent
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
