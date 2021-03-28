class WorkoutsController < ApplicationController
  before_action :set_user
  before_action :set_workout, except: [:index, :new, :create, :filter]
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @workouts = Workout
      .where(user_id: @user.id)
      .order(created_at: :desc)
      .limit(25)

    @lift_data = Sett.user_history(@user)
    @wilks_data = WilksScore.user_history(@user)
    @workout_data = Workout.user_history(@user)
    @one_rep_max_data = Sett.user_one_rep_max_history(@user)
    @best_squat = Sett.user_best_for_lift(@user, 'Back Squat', one_rep_max_only: true)
    @best_bench = Sett.user_best_for_lift(@user, 'Bench Press', one_rep_max_only: true)
    @best_deadlift = Sett.user_best_for_lift(@user, 'Deadlift', one_rep_max_only: true)
    @best_projected_squat = Sett.user_best_for_lift(@user, 'Back Squat')
    @best_projected_bench = Sett.user_best_for_lift(@user, 'Bench Press')
    @best_projected_deadlift = Sett.user_best_for_lift(@user, 'Deadlift')
  end

  def filter
    if params[:variant] == 'all'
      @workouts = Workout.where(user_id: @user.id).order(created_at: :desc).limit(25)
    elsif params[:variant]
      @workouts = Workout
      .where(user_id: @user.id, variant: params[:variant])
      .order(created_at: :desc)
      .limit(25)
    end

    @filtered_workouts_count = @workouts.count

    respond_to do |format|
      format.js
    end
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
      redirect_to user_workout_path(@user, @workout)
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

    respond_to do |format|
      format.html { redirect_to user_workouts_path(@user), notice: "Workout successfully deleted" }
      format.js
    end
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
