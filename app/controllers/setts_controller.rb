class SettsController < ApplicationController
  before_action :set_user, only: [:filter]
  before_action :authenticate_user!

  def filter
    if params[:lift] == 'all'
      @setts = Sett
        .joins(:workout)
        .where(workouts: { user_id: @user.id } )
        .order(created_at: :desc)
        .limit(25)
    elsif params[:lift]
      @setts = Sett
        .where(lift_id: params[:lift])
        .joins(:workout)
        .where(workouts: { user_id: @user.id })
        .order(created_at: :desc)
        .limit(25)
    end

    @filtered_setts_count = @setts.count
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @sett = Sett.find params[:id]

    @sett.destroy
    
    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user ||= User.find params[:user_id]
  end
end
