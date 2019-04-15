class CriteriaTypesController < ApplicationController
  before_action :set_criteria_type, only: [:show, :edit, :update, :destroy]

  # GET /criteria_types
  # GET /criteria_types.json
  def index
    @criteria_types = CriteriaType.all
  end

  # GET /criteria_types/1
  # GET /criteria_types/1.json
  def show
  end

  # GET /criteria_types/new
  def new
    @criteria_type = CriteriaType.new
  end

  # GET /criteria_types/1/edit
  def edit
  end

  # POST /criteria_types
  # POST /criteria_types.json
  def create
    @criteria_type = CriteriaType.new(criteria_type_params)

    respond_to do |format|
      if @criteria_type.save
        format.html { redirect_to @criteria_type, notice: 'Criteria type was successfully created.' }
        format.json { render :show, status: :created, location: @criteria_type }
      else
        format.html { render :new }
        format.json { render json: @criteria_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criteria_types/1
  # PATCH/PUT /criteria_types/1.json
  def update
    respond_to do |format|
      if @criteria_type.update(criteria_type_params)
        format.html { redirect_to @criteria_type, notice: 'Criteria type was successfully updated.' }
        format.json { render :show, status: :ok, location: @criteria_type }
      else
        format.html { render :edit }
        format.json { render json: @criteria_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criteria_types/1
  # DELETE /criteria_types/1.json
  def destroy
    @criteria_type.destroy
    respond_to do |format|
      format.html { redirect_to criteria_types_url, notice: 'Criteria type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criteria_type
      @criteria_type = CriteriaType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criteria_type_params
      params.require(:criteria_type).permit(:name)
    end
end
