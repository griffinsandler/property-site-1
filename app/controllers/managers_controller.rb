class ManagersController < ApplicationController
    require 'ostruct'
    skip_before_action :verify_authenticity_token
    #before_action :force_log_in
    before_action :confirm_logged_in
    
    def show
        @manager = Manager.find(session[:user_id])
        @joinrequests = Joinrequest.where(:manager_id => @manager)
        if !@joinrequests.empty?
            @JRBundles = Array.new
            @joinrequests.each do |i|
                newBundle = OpenStruct.new
                newBundle.joinRequest = i
                newBundle.property = Property.find(i.property_id)
                newBundle.tenant = Tenant.find(i.tenant_id)
                @JRBundles.push(newBundle)
            end
        end
    end
    def update
        @manager = Manager.find(session[:user_id])
        params_map = ActiveSupport::HashWithIndifferentAccess.new(params[:manager])
        @manager.update(params_map)
        redirect_to '/managers/show'
    end
    def edit
        @manager = Manager.find(session[:user_id])
    end
    
    def respond
        @joinrequest = Joinrequest.find(params[:id])
        if params[:op] == 'accept'
            @tenant = Tenant.find(@joinrequest.tenant_id)
            @tenant.property_id = @joinrequest.property_id
            @tenant.save
        end
        @joinrequest.delete
        redirect_to '/managers/show'
    end
end
