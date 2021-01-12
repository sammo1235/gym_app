class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.all
      .order(created_at: :asc)
  end

  def show
    @workout = Workout.find params[:id]
  end

  def new
    @workout = Workout.new
    3.times { @workout.setts.build }
  end

  def create
    @workout = Workout.new workout_params
    if @workout.save
      redirect_to workout_url(@workout)
    else
      render 'new'
    end
  end

  private

    def workout_params
      params.require(:workout).permit(:variant, :notes, setts_attributes: [:id, :weight, :reps, :lift_id, :_destroy])
    end
end
