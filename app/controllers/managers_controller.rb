class ManagersController < ApplicationController
    skip_before_action :verify_authenticity_token
    #before_action :force_log_in
    before_action :confirm_logged_in
    
    def show
        @manager = Manager.find(session[:user_id])
    end
end
