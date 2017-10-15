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
end