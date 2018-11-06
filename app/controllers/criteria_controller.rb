class CriteriaController < ApplicationController
  before_action :set_criterium, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  has_scope :score, :degree, :criteria_type_id, :position_type_id
  load_and_authorize_resource
  # GET /criteria
  # GET /criteria.json
  def index
    respond_to do |format|
      @criteria = apply_scopes(Criterium).order(sort_column + " " + sort_direction).load_criteria(params[:page], params[:per_page])
      format.html
      json_string = CriteriaSerializer.new(@criteria).serialized_json
      format.json {render json: json_string}
    end
    #render json: @criteria, root: "data"
  end

  # GET /criteria/1
  # GET /criteria/1.json
  def show
    respond_to do |format|
      format.html
      format.json {render json: @criterium}
    end
  end

  # GET /criteria/new
  def new
    @criterium = Criterium.new
  end

  # GET /criteria/1/edit
  def edit
  end

  # POST /criteria
  # POST /criteria.json
  def create
    @criterium = Criterium.new(criterium_params)

    respond_to do |format|
      if @criterium.save
        format.html { redirect_to @criterium, notice: 'Criterio fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @criterium }
      else
        format.html { render :new }
        format.json { render json: @criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criteria/1
  # PATCH/PUT /criteria/1.json
  def update
    respond_to do |format|
      if @criterium.update(criterium_params)
        format.html { redirect_to @criterium, notice: 'Criterio fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @criterium }
      else
        format.html { render :edit }
        format.json { render json: @criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criteria/1
  # DELETE /criteria/1.json
  def destroy
    @criterium.destroy
    respond_to do |format|
      format.html { redirect_to criteria_url, notice: 'Criterio fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criterium
      @criterium = Criterium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criterium_params
      params.require(:criterium).permit(:criteria_type, :score, :degree_id, :degree)
    end

    def sort_column
      Criterium.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
