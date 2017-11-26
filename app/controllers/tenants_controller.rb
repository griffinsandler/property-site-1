class TenantsController < ApplicationController
 skip_before_action :verify_authenticity_token
 #before_action :force_log_in
 before_action :confirm_logged_in
 
  def index
    @tenants = Tenant.where(:property_id => @property)
  end
  
  def show
    @tenant = Tenant.find(session[:user_id]) 
    unless @tenant.property_id.blank?
      @property = Property.find(@tenant.property_id)
      @roommates = Tenant.where("property_id = ? AND id != ?", @property.id, @tenant.id)
    end
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

