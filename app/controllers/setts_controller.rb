class SettsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @sett = Sett.find params[:id]

    @sett.destroy
    
    respond_to do |format|
      format.js
    end
  end
end
