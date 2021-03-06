class SessionsController < ApplicationController
  # User does not need to be logged in before logged in. 
  skip_before_filter :set_current_user
  
  #session needs a number for the application to differentiate on facebook log ins
  def Managerfb
    session[:check] = 1
    redirect_to '/auth/facebook'
  end
   
  def Tenantfb
    session[:check] = 2
    redirect_to '/auth/facebook'
  end
  
  def signinfb
    session[:check] = 3
    redirect_to '/auth/facebook'
  end
  
  #facebook authentication redirects based on the type of user signing up 
  def facebookcheck
    auth=request.env["omniauth.auth"]
    session[:auth] = auth
    if (session[:check] == 1)
        redirect_to '/create/manager'
    elsif (session[:check] == 2)
        redirect_to '/create/tenant'
    else
      #differentiates the redirection for the log in of a tenant or manager
      if Manager.where(:provider => auth["provider"], :uid => auth["uid"]).exists?
        user=Manager.find_by(:provider => auth["provider"], :uid => auth["uid"])
        session[:user_id] = user.id
        redirect_to '/managers/show'
      elsif Tenant.where(:provider => auth["provider"], :uid => auth["uid"]).exists?
        user = Tenant.find_by(:provider => auth["provider"], :uid => auth["uid"]) 
        session[:user_id] = user.id
        redirect_to '/tenants/show'
      #redirects incorrect sign ins
      else
        flash[:notice] = 'Incorrect login information.'
        redirect_to '/signin'
      end
    end
  end
  
  #creates new session 
  def new
    if params[:op] == 'local'
      params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:session])
      #searches the database of managers and tenants to redirect propperly 
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
      flash[:notice] = 'Incorrect login information.'
      redirect_to '/signin'
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
      session[:user_id] = user.id  
      redirect_to '/managers/show'  
      else
        auth = session[:auth]
        if Manager.find_by(:email => auth["info"]["email"])
          flash[:notice] = 'Email already used.'
          redirect_to '/create'
        else
          user=Manager.create_with_omniauth(session[:auth])
        session[:user_id] = user.id
         redirect_to '/managers/show'
        end
      end
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
      session[:user_id] = user.id
      render 'search'
      else
        auth = session[:auth]
        if Tenant.find_by(:email => auth["info"]["email"])
          flash[:notice] = 'Email already used.'
          redirect_to '/create'
        else  
         user=Tenant.create_with_omniauth(session[:auth])
          session[:user_id] = user.id
          render 'search'
        end
      end
  end
  
  # Searches for a Property by address using a query derived from user input.  
  def search
      params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:query])
      @result = Property.where(:address => params_map[:address]).take
      if @result
        @manager = Manager.find(@result.manager_id)
        flash.clear
        render 'search'
      else
        flash[:notice] = "Your search returned no results."
        render 'search'
      end
  end
  
  # Ends the user's current session, logging them out. 
  def destroy
    session.delete(:user_id)
    session.delete(:auth)
    flash[:notice] = 'Logged out successfully.'
    redirect_to "/home"
  end
  
  # Sends a request to join a particular Property from a Tenant to the Manager who owns the property.
  def sendreq
    newReq = Joinrequest.new(:resolved => false, :manager_id => params[:id], :property_id => params[:pid], :tenant_id => session[:user_id])
    newReq.save
    redirect_to "/tenants/show"
  end
end
