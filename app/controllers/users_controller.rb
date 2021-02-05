class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    @users = User.all
      .includes(:setts)
      .ordered_by_wilks
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