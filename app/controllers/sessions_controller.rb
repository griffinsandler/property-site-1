class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_filter :set_current_user
  def create
    auth=request.env["omniauth.auth"]
    user=Manager.find_by(:provider => auth["provider"], :uid => auth["uid"]) ||
      Manager.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to properties_path
  end
  def destroy
    session.delete(:user_id)
    flash.now[:notice] = 'Logged out successfully.'
    redirect_to "/home"
  end
end