class TenantsController < ApplicationController
 # skip_before_action :verify_authenticity_token
  def index
    @tenants = Tenant.all
  end
  def show
    @tenant = Tenant.find(params[:id]) 
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