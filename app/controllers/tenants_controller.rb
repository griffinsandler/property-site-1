class TenantsController < ApplicationController
 skip_before_action :verify_authenticity_token
  def index
    @tenents = Tenant.where(:property_id => @property)
  end
  def show
    @tenant = Tenant.find(session[:user_id]) 
    @property = Property.find(@tenant.property_id)
  end
  def create
     params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:tenant])
    @tenant = Tenant.new(params_map)
    if @tenant.save
      redirect_to @tenant
    else
      render "new"
    end
end
end

