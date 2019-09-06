class LiftsController < ApplicationController
  before_action :set_lift, only: [:show, :edit, :update, :destroy]

  # GET /lifts
  # GET /lifts.json
  def index
    @lifts = Lift.all
  end

  # GET /lifts/1
  # GET /lifts/1.json
  def show
  end

  # GET /lifts/new
  def new
    @lift = Lift.new
  end

  # GET /lifts/1/edit
  def edit
  end

  # POST /lifts
  # POST /lifts.json
  def create
    @lift = Lift.new(lift_params)

    respond_to do |format|
      if @lift.save
        format.html { redirect_to @lift, notice: 'Lift was successfully created.' }
        format.json { render :show, status: :created, location: @lift }
      else
        format.html { render :new }
        format.json { render json: @lift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lifts/1
  # PATCH/PUT /lifts/1.json
  def update
    respond_to do |format|
      if @lift.update(lift_params)
        format.html { redirect_to @lift, notice: 'Lift was successfully updated.' }
        format.json { render :show, status: :ok, location: @lift }
      else
        format.html { render :edit }
        format.json { render json: @lift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lifts/1
  # DELETE /lifts/1.json
  def destroy
    @lift.destroy
    respond_to do |format|
      format.html { redirect_to lifts_url, notice: 'Lift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lift
      @lift = Lift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lift_params
      params.require(:lift).permit(:name)
    end
end
