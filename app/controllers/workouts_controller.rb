class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.all
      .order(created_at: :asc)
  end

  def show
    @workout = Workout.find params[:id]
  end
end
