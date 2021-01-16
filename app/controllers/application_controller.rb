class ApplicationController < ActionController::Base
  before_action :confirgure_permitted_parameters, if: :devise_controller?

  protected

  def confirgure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :age, :bodyweight, :gender])
  end
end
