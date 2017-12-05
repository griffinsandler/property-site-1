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
  def pay
    @tenant = Tenant.find(session[:user_id])
    @property = Property.find(@tenant.property_id)
    if @tenant.rent.nil?
      @tenant.rent = (@property.monthly_rent / @property.curr_num_tenants)
      @property.rent = @property.monthly_rent
      @property.rent = @property.rent.to_f - @tenant.rent.to_f
      @tenant.save
      @property.save
      flash.now[:notice] = 'Rent payment complete.'
    else
      flash.now[:notice] = 'Rent already payed. See you next month!'
    end
    redirect_to action: "show"
  end
end

