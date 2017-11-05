class TenantsController < ApplicationController
  def new
    @tenant = Tenant.new
  end
   def show
    @tenant = Tenant.find(session[:user_id])
    @properties = Property.where(:tenant_id => @tenant)
  end
end
