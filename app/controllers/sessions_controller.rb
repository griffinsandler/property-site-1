class SessionsController < ApplicationController
  def new
  end
  def create
    landlord = Landlord.find_by(email: params[:session][:email].downcase)
    if landlord && TRUE
        log_in landlord
        redirect_to landlord
    # Log the user in and redirect to the user's show page.
    else
    flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
    end
 end

  def destroy
  end
end
