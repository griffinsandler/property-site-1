class SessionsController < ApplicationController
  # User does not need to be logged in before logged in. 
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
      session[:check] = 1
      redirect_to '/managers/show'
    elsif user.is_a?(Tenant)
      session[:user_id] = user.id
      session[:check] = 2
      redirect_to '/tenants/show'
    else
      session[:auth] = auth
      render 'new'
    end
  end
  
  # Creates a new user with type 'Manager', designed to support both local and Facebook sign ups. 
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
  
  # Creates a new user with type 'Tenant', designed to support both local and Facebook sign ups. 
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
    render 'search'
  end
  
  def create
  end
  
  # Searches for a Property by address using a query derived from user input.  
  def search
      params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:query])
      @result = Property.where(:address => params_map[:address]).take
      @manager = Manager.find(@result.manager_id)
  end
  
  # Ends the user's current session, logging them out. 
  def destroy
    session.delete(:user_id)
    flash.now[:notice] = 'Logged out successfully.'
    redirect_to "/home"
  end
  
  # Sends a request to join a particular Property from a Tenant to the Manager who owns the property.
  def sendreq
    newReq = Joinrequest.new(:resolved => false, :manager_id => params[:id], :property_id => params[:pid], :tenant_id => session[:user_id])
    newReq.save
    redirect_to "/tenants/show"
  end
end
