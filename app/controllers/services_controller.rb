class ServicesController < ApplicationController
skip_before_action :verify_authenticity_token
 #before_action :force_log_in
 before_action :confirm_logged_in
 
    #creates a new service request with the users name and address already autofilled 
    def new
        @tenant = Tenant.find(session[:user_id])
        @property = Property.find(@tenant.property_id)
    end
   
   #allows for the managers to respond to the services 
    def respond
        @service = Service.find(params[:id])
        @service.response = params[:services][:response]
        @service.resolved = true
        @service.save
        redirect_to '/managers/show'
    end
    #creates the service request
    def create
        params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:services])
        @service = Service.new(params_map)
        @tenant = Tenant.find(session[:user_id])
        @property = Property.find(@tenant.property_id)
        @manager = Manager.find(@property.manager_id)
        @service.manager_id = @manager.id
        @service.property_id = @property.id
        @service.tenant_id = @tenant.id
        #sets resolved to false, only tenants have the ability to set these to completed
        @service.resolved = false
        if @service.save
            ServiceMailer.reminder(@service).deliver_now
            redirect_to '/tenants/show'
        else
          render "new"
        end
    end

    #shows all the service requests 
    def index
        @service = Service.all()
    end

   #shows more information for the given service request. Allows for showing limitted information on profile page 
    def show
        @service = Service.find(params[:id])
    end 
end
