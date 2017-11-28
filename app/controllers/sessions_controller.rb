class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_filter :set_current_user
  def new
    if params[:op] == 'local'
        params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:session])
        user=Manager.find_by(:email => params_map["email"], :password => params_map["password"]) || Tenant.find_by(:email => params_map["email"], :password => params_map["password"])
    else
      auth=request.env["omniauth.auth"]
      user=Manager.find_by(:provider => auth["provider"], :uid => auth["uid"]) || Tenant.find_by(:provider => auth["provider"], :uid => auth["uid"])
    end
    if user.is_a?(Manager)
      session[:user_id] = user.id
      redirect_to '/managers/show'
    else if user.is_a?(Tenant)
      session[:user_id] = user.id
      redirect_to '/tenants/show'
    else
      session[:auth] = auth
      render 'new'
    end
    end
  end
  
  def createManager
    if params[:op] == 'local'
        params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:manager])
        user = Manager.new(params_map)
        if !user.save
          render 'create'
          return
        end
    else
      user=Manager.create_with_omniauth(session[:auth])
    end
    session[:user_id] = user.id
    redirect_to '/managers/show'
  end
  
  def createTenant
    if params[:op] == 'local'
        params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:tenant])
        user = Tenant.new(params_map)
        if !user.save
          render 'create'
          return
        end
    else
      user=Tenant.create_with_omniauth(session[:auth])
    end
    session[:user_id] = user.id
    redirect_to '/tenants/show'
  end
  
  def create
  end
  
  def destroy
    session.delete(:user_id)
    flash.now[:notice] = 'Logged out successfully.'
    redirect_to "/home"
  end
end
