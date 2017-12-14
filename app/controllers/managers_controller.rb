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
        @properties = Property.where(:manager_id => @manager)
        @services = Service.where("manager_id = ? AND resolved = ?", @manager, false)
        @propRents = Hash.new
        @properties.each do |p|
            @rents = Rent.where(:property_id => p)
            @propRents[p] = @rents
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
            @property = Property.find(@joinrequest.property_id)
            if @property.max_num_tenants == @property.curr_num_tenants
                flash[:notice] = "This property is full right now!"
                return
            end
            @property.curr_num_tenants += 1
            @tenant = Tenant.find(@joinrequest.tenant_id)
            @tenant.property_id = @joinrequest.property_id
            @currRent = Rent.where("property_id = ? AND (due = ? OR due = ?)",  @joinrequest.property_id, Time.now + 1.month, Date.new(Time.now.year + 1, 1, 1)).first
            if @currRent
                @tenant.rent << @currRent
                @currRent.save
                @tenant.save
                flash[:notice] = "Added?"
            else
                @rent = Rent.new
                @rent.property_id = @joinrequest.property_id
                @rent.manager_id = @joinrequest.manager_id
                @rent.total = @property.monthly_rent
                if (Time.now.month != 12)
                    @rent.due = Date.new(Time.now.year, Time.now.month + 1, 1)
                else
                    @rent.due = Date.new(Time.now.year + 1, 1, 1) 
                end
                @rent.save 
                @tenant.rent << @rent
                @tenant.save
            end
            @property.save
        end
        @joinrequest.delete
        redirect_to '/managers/show'
    end
end
