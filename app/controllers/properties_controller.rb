class PropertiesController < ApplicationController
  #before_action :force_log_in
  skip_before_action :verify_authenticity_token
  before_action :confirm_logged_in
  
  #shows all propertyies that have the manager id of the current manager 
  def index
    @manager = Manager.find(session[:user_id])
    @properties = Property.where(:manager_id => @manager)
  end
  #gives more infromation about a singular property. Must be on the manager owns
  def show
    @property = Property.find(params[:id])
    @tenants = Tenant.where(:property_id => @property.id)
  end
 #creates new property  
  def new
    @property = Property.new
  end
  #maps the features to the new property 
  def create
    params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:property])
    @property = Property.new(params_map)
    #creates property with the current managers id for manager id 
    @property.manager_id = session[:user_id]
    if @property.save
            flash[:notice] = "#{@property.name} was successfully created."
        else
            flash[:notice] = "Property could not be created because #{@property.errors.full_messages}"
        end
    redirect_to properties_path
  end
 #allows for the editting of a property by the manager only 
  def edit
    @property = Property.find(params[:id])
  end
 #updates the features of the property to the new information 
  def update
    @property = Property.find(params[:id])
    params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:property])
    @property.update(params_map)
    redirect_to @property
  end
  
  #deletes a property
  def destroy
  @property = Property.find(params[:id])
  @property.destroy
  flash[:notice] = "Property '#{@property.name}' at '#{@property.address}' deleted."
  redirect_to properties_path
end
  
end
