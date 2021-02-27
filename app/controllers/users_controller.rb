class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    # no doubt there's a cleaner way to do this
    if params[:username] || params[:male] || params[:female] || params[:_40] || params[:_61] || params[:_81]
      @users = User.search({
        username: params[:username], 
        male: params[:male],
        female: params[:female],
        bodyweight: [
          params[:_40],
          params[:_61],
          params[:_81]
        ],
      })
        .includes(:setts)
        .ordered_by_wilks
    else
      @users = User.all
        .includes(:setts)
        .ordered_by_wilks
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path @user
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end
end