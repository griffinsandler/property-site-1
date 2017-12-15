class ServiceMailer < ApplicationMailer
    
    default from: 'abode@gmail.com'
    
    def reminder(req)
        @service = req
        @manager = Manager.find(@service.manager_id)
        @property = Property.find(@service.property_id)
        @tenant = Tenant.find(@service.tenant_id)
        @url = "/services/show/#{@service.id}"
        mail(to: @manager.email, subject: "New Service Request: #{@service.subject}")
    end
end
