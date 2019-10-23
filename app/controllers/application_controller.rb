class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  def status
    render json: { data: 'ok' }
  end
end
