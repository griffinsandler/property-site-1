class ManagersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def show
        @manager = Manager.find(session[:user_id])
    end
end
