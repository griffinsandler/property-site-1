module SessionsHelper
    # Logs in the given user.
    def log_in(landlord)
    session[:landlord_id] = landlord.id
  end
  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= Landlord.find_by(id: session[:landlord_id])
  end
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
end
