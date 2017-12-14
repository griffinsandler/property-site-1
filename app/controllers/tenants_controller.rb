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
      @services = Service.where("tenant_id = ? AND resolved = ?", @tenant.id, true)
      @roommateRentTot = 0
      unless @roommates.empty?
        @roommates.each do |r| 
          if not r.rentNum.nil?
            @roommateRentTot += r.rentNum ||= 0
          end
        end
      end
      if not @tenant.rentNum.nil?
        @roommateRentTot +=  @tenant.rentNum
      end
    end
  end
  
  def service
    @service = Service.find(params[:id])
    if params[:op] == 'completed'
      @service.delete
    else
      @service.resolved = false
      @service.save
    end
    redirect_to '/tenants/show'
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
  
  def edit
    @tenant = Tenant.find(session[:user_id])
  end
  
  def update
      @tenant = Tenant.find(session[:user_id])
      params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:tenant])
      @tenant.update(params_map)
      redirect_to '/tenants/show'
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
  
  def dummypay
    @rent = Rent.find(params[:id])
    @tenant = Tenant.find(session[:user_id])
    @rent.total -= @tenant.rentNum
    @rent.save
    redirect_to '/tenants/show'
  end
end

