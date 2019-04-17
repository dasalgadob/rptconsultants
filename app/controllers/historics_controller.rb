class HistoricsController < ApplicationController
  before_action :set_historic, only: [:show, :edit, :update, :destroy]

  # GET /historics
  # GET /historics.json
  def index
    @valuation = Valuation.find(params[:valuation_id])
    @company = Company.find(@valuation.company  )   
    @historics = Historic.where("valuation_id = ?", params[:valuation_id]).order(:created_at)
  end

  # GET /historics/1
  # GET /historics/1.json
  def show
  end

  # GET /historics/new
  def new
    @historic = Historic.new
  end

  # GET /historics/1/edit
  def edit
  end

  # POST /historics
  # POST /historics.json
  def create
    @historic = Historic.new(historic_params)

    respond_to do |format|
      if @historic.save
        format.html { redirect_to @historic, notice: 'Historic was successfully created.' }
        format.json { render :show, status: :created, location: @historic }
      else
        format.html { render :new }
        format.json { render json: @historic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historics/1
  # PATCH/PUT /historics/1.json
  def update
    respond_to do |format|
      if @historic.update(historic_params)
        format.html { redirect_to @historic, notice: 'Historic was successfully updated.' }
        format.json { render :show, status: :ok, location: @historic }
      else
        format.html { render :edit }
        format.json { render json: @historic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historics/1
  # DELETE /historics/1.json
  def destroy
    @historic.destroy
    respond_to do |format|
      format.html { redirect_to historics_url, notice: 'Historic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historic
      @historic = Historic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historic_params
      params.require(:historic).permit(:type, :user_id, :valuation_id, :previous_fields, :new_fields)
    end
end
