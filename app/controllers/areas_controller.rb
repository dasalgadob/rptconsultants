class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /areas
  # GET /areas.json
  def index
    @company = Company.find(params[:company_id])
    @areas = Area.all
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @company = Company.find(params[:company_id])
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @company = Company.find(params[:company_id])
    @area = Area.new(area_params)
    @area.company = @company

    respond_to do |format|
      if @area.save
        format.html { redirect_to company_areas_path, notice: 'Area fue creada exitosamente.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to @area, notice: 'Area fue actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to company_areas_path(@area.company), notice: 'Area fue destruida exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :company_id)
    end
end
