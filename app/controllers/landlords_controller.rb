class LandlordsController < ApplicationController
  #before_action :force_log_in
  skip_before_action :verify_authenticity_token
  def index
    @landlords = Landlord.all
  end
  def show
    @landlord = Landlord.find(params[:id])
  end
  def new
    @landlord = Landlord.new
  end
  def create
     params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:landlord])
    @landlord = Landlord.new(params_map)
    if @landlord.save
      redirect_to @landlord
    else
      render "new"
    end
  end
end