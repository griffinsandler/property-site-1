class PropertiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @properties = Property.all
  end
  def show
    @property = Property.find(params[:id])
  end
  def new
    @property = Property.new
  end
  def create
    params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:property])
    @property = Property.new(params_map)
    if @property.save
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
end