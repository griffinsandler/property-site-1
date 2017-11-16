class PropertiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @manager = Manager.find(session[:user_id])
    @properties = Property.where(:manager_id => @manager)
  end
  def show
    @property = Property.find(params[:id])
    @tenants = Tenant.where(:property_id => @property.id)
  end
  def new
    @property = Property.new
  end
  def create
    params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:property])
    @property = Property.new(params_map)
    @property.manager_id = session[:user_id]
    if @property.valid?
          @property.save
          redirect_to @property
      else
          render "new"
      end
    
  end
  def edit
    @property = Property.find(params[:id])
  end
  def update
    @property = Property.find(params[:id])
    params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:property])
    @property.update(params_map)
    redirect_to @property
  end
  
  def destroy
  @property = Property.find(params[:id])
  @property.destroy
  flash[:notice] = "Property '#{@property.name}' at '#{@property.address}' deleted."
  redirect_to properties_path
end
  
end
