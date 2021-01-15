class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]


  def index
    @workouts = Workout
      .where(user_id: @user.id)
      .order(created_at: :desc)
  end

  def show
  end

  def new
    @workout = Workout.new
    3.times { @workout.setts.build }
  end

  def create
    @workout = Workout.new workout_params
    if @workout.save
      redirect_to workout_path(@workout)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @workout.update workout_params
      redirect_to user_workout_path(@user, @workout)
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
      params.require(:workout).permit(:variant, :notes, setts_attributes: [:id, :weight, :reps, :lift_id, :_destroy])
    end

    def set_workout
      @workout = Workout.find params[:id]
    end

    def set_user
      @user = User.find params[:user_id]
    end
end
