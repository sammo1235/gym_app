class WorkUnitsController < ApplicationController
  before_action :set_work_unit, only: [:show, :edit, :update, :destroy]

  # GET /work_units
  # GET /work_units.json
  def index
    @work_units = WorkUnit.all.order(:created_at).reverse_each
  end

  # GET /work_units/1
  # GET /work_units/1.json
  def show
  end

  # GET /work_units/new
  def new
    @work_unit = WorkUnit.new
    @work_out = WorkOut.find(params[:work_out_id])
    @user = @work_out.user
  end

  # GET /work_units/1/edit
  def edit
  end

  # POST /work_units
  # POST /work_units.json
  def create
    @work_unit = WorkUnit.new(work_unit_params)

    respond_to do |format|
      if @work_unit.save
        @work_unit.work_out.calculate_workout_volume

        format.html { redirect_to work_out_path(@work_unit.work_out.id), notice: 'Work unit was successfully created.' }
        format.json { render :show, status: :created, location: @work_unit }
      else
        format.html { render :new }
        format.json { render json: @work_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_units/1
  # PATCH/PUT /work_units/1.json
  def update
    respond_to do |format|
      if @work_unit.update(work_unit_params)
        @work_unit.work_out.calculate_workout_volume

        format.html { redirect_to work_out_path(@work_unit.work_out.id), notice: 'Work unit and work out were successfully updated.' }
        format.json { render :show, status: :ok, location: @work_unit }
      else
        format.html { render :edit }
        format.json { render json: @work_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_units/1
  # DELETE /work_units/1.json
  def destroy
    workout = @work_unit.work_out
    @work_unit.destroy
    workout.calculate_workout_volume
    respond_to do |format|
      format.html { redirect_to work_out_path(workout.id), notice: 'Work unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_unit
      @work_unit = WorkUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_unit_params
      params.require(:work_unit).permit(:weight, :reps, :lift, :user, :work_out)
    end
end
