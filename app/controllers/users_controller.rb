class UsersController < ApplicationController
  before_action :set_user, except: :index

  SEARCH_PARAMS = ["username", "male", "female", "_40", "_60", "_80", "_100", "_120"].freeze

  def index
    if (params.keys & SEARCH_PARAMS).present?
      @users = User.search({
        username: params[:username], 
        male: params[:male],
        female: params[:female],
        bodyweight: [
          params[:_40],
          params[:_60],
          params[:_80],
          params[:_100],
          params[:_120]
        ],
      })
        .includes(:setts)
        .ordered_by_wilks
      @count = @users.count
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