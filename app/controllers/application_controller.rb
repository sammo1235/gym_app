class ApplicationController < ActionController::Base
  def status
    render json: { data: 'ok' }
  end
end
