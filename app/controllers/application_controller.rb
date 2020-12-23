class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    added_attrs = [:github_username, :first_name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs

    # For additional fields in app/views/devise/sessions/new.html.erb
    # devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
  
end
