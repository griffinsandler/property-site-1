class ServicesController < ApplicationController
skip_before_action :verify_authenticity_token
 #before_action :force_log_in
 before_action :confirm_logged_in
 
 def new
    @tenant = Tenant.find(session[:user_id])
    @property = Property.find(@tenant.property_id)
 end
def create
    params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:services])
    @service = Service.new(params_map)
    @tenant = Tenant.find(session[:user_id])
    @property = Property.find(@tenant.property_id)
    @manager = Manager.find(@property.manager_id)
    @service.manager_id = @manager.id
    @service.property_id = @property.id
    @service.tenant_id = @tenant.id
    if @service.save
      redirect_to '/tenants/show'
    else
      render "new"
    end
 end

    def index
        @service = Service.all()
    end

    def show
     @service = Service.find(params[:id])
    end 
end
