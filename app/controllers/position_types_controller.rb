class PositionTypesController < ApplicationController
  before_action :set_position_type, only: [:show, :edit, :update, :destroy]

  # GET /position_types
  # GET /position_types.json
  def index
    @position_types = PositionType.all
  end

  # GET /position_types/1
  # GET /position_types/1.json
  def show
  end

  # GET /position_types/new
  def new
    @position_type = PositionType.new
  end

  # GET /position_types/1/edit
  def edit
  end

  # POST /position_types
  # POST /position_types.json
  def create
    @position_type = PositionType.new(position_type_params)

    respond_to do |format|
      if @position_type.save
        format.html { redirect_to @position_type, notice: 'Position type was successfully created.' }
        format.json { render :show, status: :created, location: @position_type }
      else
        format.html { render :new }
        format.json { render json: @position_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /position_types/1
  # PATCH/PUT /position_types/1.json
  def update
    respond_to do |format|
      if @position_type.update(position_type_params)
        format.html { redirect_to @position_type, notice: 'Position type was successfully updated.' }
        format.json { render :show, status: :ok, location: @position_type }
      else
        format.html { render :edit }
        format.json { render json: @position_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /position_types/1
  # DELETE /position_types/1.json
  def destroy
    @position_type.destroy
    respond_to do |format|
      format.html { redirect_to position_types_url, notice: 'Position type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position_type
      @position_type = PositionType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def position_type_params
      params.require(:position_type).permit(:name)
    end
end
