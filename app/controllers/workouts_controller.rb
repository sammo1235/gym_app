class WorkoutsController < ApplicationController
  before_action :set_user
  before_action :set_workout, except: [:index, :new, :create, :wilks_history]
  before_action :authenticate_user!, except: [:index, :show, :wilks_history]


  def index
    @workouts = Workout
      .where(user_id: @user.id)
      .order(created_at: :desc)
      .limit(25)
    @setts = @user.setts
      .order(created_at: :desc)
      .limit(25)

    @lift_data = Sett.user_history(@user)
    @wilks_data = WilksScore.user_history(@user)
    @workout_data = Workout.user_history(@user)
  end

  def show
  end

  def new
    @workout = Workout.new
    @workout.setts.build
  end

  def create
    @workout = current_user.workouts.build workout_params
    if @workout.save
      redirect_to user_workout_path(current_user, @workout)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @workout.update workout_params
      redirect_to user_workout_path(current_user, @workout)
    else
      render :edit
    end
  end

  def destroy
    @workout.destroy
    redirect_to user_workouts_path(@user)
  end

  private

  def workout_params
    params.require(:workout).permit(:user_id, :variant, :notes, setts_attributes: [:id, :weight, :reps, :lift_id, :_destroy])
  end

  def set_workout
    @workout = Workout.find params[:id]
  end

  def set_user
    @user = User.find params[:user_id]
  end
end
