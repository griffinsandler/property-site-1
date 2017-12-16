class TenantsController < ApplicationController
 skip_before_action :verify_authenticity_token
 #before_action :force_log_in
 before_action :confirm_logged_in
 
 #gets all tenants that have the same property id# 
  def index
    @tenants = Tenant.where(:property_id => @property)
  end
  
 #shows tenant with user id that matches the tenant logged in#
  def show
    @tenant = Tenant.find(session[:user_id]) 
   #makes sure tenant has a property id to search for its roommates, property, and services# 
    unless @tenant.property_id.blank?
      @property = Property.find(@tenant.property_id)
      @roommates = Tenant.where("property_id = ? AND id != ?", @property.id, @tenant.id)
      @services = Service.where("tenant_id = ? AND resolved = ?", @tenant.id, true)
      @roommateRentTot = 0
      #checks if roommates are empty before calculating total rent 
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
  
  
  #outlines service request option for completed and incomplete 
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
  
 #creates the tenant with the inputs created by the tenant log in#
  def create
     params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:tenant])
    @tenant = Tenant.new(params_map)
    if @tenant.save
      redirect_to @tenant
    else
      render "new"
    end
  end
  
  #allows tenants to edit information# 
  def edit
    @tenant = Tenant.find(session[:user_id])
  end
  
  #maps the edits from edit to the tenants profile 
  def update
      @tenant = Tenant.find(session[:user_id])
      params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:tenant])
      @tenant.update(params_map)
      redirect_to '/tenants/show'
  end
  
  #allows for penants to pay their rent to their landlord
  def pay
    @tenant = Tenant.find(session[:user_id])
    @property = Property.find(@tenant.property_id)
    #if tenant hasnt paid rent
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
  
  #used until we figure out paypal to test payment 
  def dummypay
    @rent = Rent.find(params[:id])
    @tenant = Tenant.find(session[:user_id])
    @rent.total -= @tenant.rentNum
    @rent.save
    redirect_to '/tenants/show'
  end
end

