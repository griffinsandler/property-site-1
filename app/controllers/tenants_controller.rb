class TenantsController < ApplicationController
 skip_before_action :verify_authenticity_token
 #before_action :force_log_in
 before_action :confirm_logged_in
 require 'stripe'
 Stripe.api_key = "sk_live_8NHE2vkkiUHunwbpPYZFrG0L"
 
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
      if params[:code]
          uri = URI.parse("https://connect.stripe.com/oauth/token")
          @response = Net::HTTP.post_form(uri, "client_secret" => "sk_live_8NHE2vkkiUHunwbpPYZFrG0L",
            "code" => params[:code],
            "grant_type" => "authorization_code")
          @JSONResponse = JSON.parse(@response.body)
          puts @response.body
          @tenant.stripe_user_id = @JSONResponse["stripe_user_id"]
          if @tenant.save
            render 'show'
          else
            flash[:notice] = "You were unable to add a Stripe account. Please try again."
            render 'show'
          end
      end
    end
  end
  
  #An incomplete function that would allow tenants to pay landlords directly through the Stripe payment service. #
  def stripepay
    @rent = Rent.find(params[:id])
    @tenant = Tenant.find(session[:user_id])
    @property = Property.find(@tenant.property_id)
    @manager = Manager.find(@property.manager_id)
    @Customer = Stripe::Customer.retrieve(@tenant.stripe_user_id)
    @charge = Stripe::Charge.create({
      :amount => @tenant.rentNum,
      :currency => 'usd',
      :customer => @Customer,
      :destination => {
        :acount => @manager.stripe_user_id } ,
      :description => "#{@property.name} Rent #{@rent.due}, #{@tenant.name}"})
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
  

  def dummypay
    @rent = Rent.find(params[:id])
    @tenant = Tenant.find(session[:user_id])
    @rent.total -= @tenant.rentNum
    @rent.save
    redirect_to '/tenants/show'
  end
end

