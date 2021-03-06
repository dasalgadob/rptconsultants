class CriteriaController < ApplicationController
  before_action :set_criterium, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  has_scope :score, :degree, :criteria_type_id, :position_type_id
  load_and_authorize_resource
  # GET /criteria
  # GET /criteria.json
  def index
    @degrees = Degree.all
    @position_types = PositionType.all
    respond_to do |format|

      format.html {@criteria = apply_scopes(Criterium).order(sort_column + " " + sort_direction).load_criteria(params[:page], params[:per_page])}

      format.json {
        ##This way the degrees are shown in order to be seen that way on the valuations
        ##section. It is neccesary the join with degree before applying order. 
        @criteria = apply_scopes(Criterium).joins( :degree).order('degrees.number')
        json_string = CriteriaSerializer.new(@criteria).serialized_json
        render json: json_string
      }
      @criterias = apply_scopes(Criterium).order(sort_column + " " + sort_direction)
      format.xlsx
    end
    #render json: @criteria, root: "data"
  end

  def import
    begin
    Criterium.import(params[:file])
      redirect_to criteria_path, notice:  "Criterios actualizados"
    rescue Roo::HeaderRowNotFoundError => e
      redirect_to criteria_path, notice:  "Error en la cabecera de excel"
    end
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
    @criteria_types = CriteriaType.all
    @degrees = Degree.order(:number)
    @position_types = PositionType.all
    @criterium = Criterium.new
  end

  # GET /criteria/1/edit
  def edit
    @position_types = PositionType.all
    @criteria_types = CriteriaType.all
    @degrees = Degree.order(:number)
    @degree = @criterium.degree
    @position_type = @criterium.position_type
    @criteria_type = @criterium.criteria_type
  end

  # POST /criteria
  # POST /criteria.json
  def create
    @criteria_types = CriteriaType.all
    @position_types = PositionType.all
    @degrees = Degree.order(:number)
    @criterium = Criterium.new(criterium_params)
    #@position_type = PositionType.where(id: params[:position_type_id])
    puts "Position Type chosen"
    puts @position_type

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
    @position_types = PositionType.all
    @criteria_types = CriteriaType.all
    @degrees = Degree.order(:number)
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
      params.require(:criterium).permit(:criteria_type, :score, :degree_id, :degree, :description, :position_type_id, :criteria_type_id)
    end

    def sort_column
      Criterium.column_names.concat([ "degrees.number"]).include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
