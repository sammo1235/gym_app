class WorkOutsController < ApplicationController
  before_action :set_work_out, only: [:show, :edit, :update, :destroy]

  # GET /work_outs
  # GET /work_outs.json
  def index
    @work_outs = WorkOut.all
  end

  # GET /work_outs/1
  # GET /work_outs/1.json
  def show
    @work_out.calculate_total_sets
  end

  def show_work_units
    render json: WorkOut.find(params[:uuid]).work_unit
  end

  # GET /work_outs/new
  def new
    @work_out = WorkOut.new
  end

  # GET /work_outs/1/edit
  def edit
  end

  # POST /work_outs
  # POST /work_outs.json
  def create
    @work_out = WorkOut.new(work_out_params)

    respond_to do |format|
      if @work_out.save
        format.html { redirect_to @work_out, notice: 'Work out was successfully created.' }
        format.json { render :show, status: :created, location: @work_out }
      else
        format.html { render :new }
        format.json { render json: @work_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_outs/1
  # PATCH/PUT /work_outs/1.json
  def update
    respond_to do |format|
      if @work_out.update(work_out_params)
        format.html { redirect_to @work_out, notice: 'Work out was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_out }
      else
        format.html { render :edit }
        format.json { render json: @work_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_outs/1
  # DELETE /work_outs/1.json
  def destroy
    @work_out.destroy
    respond_to do |format|
      format.html { redirect_to work_outs_url, notice: 'Work out was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_out
      @work_out = WorkOut.find(params[:uuid])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_out_params
      params.require(:work_out).permit(:type, :created_at, :total_workload, :user_id, :total_sets)
    end
end
