class ValuationsController < ApplicationController
  before_action :set_valuation, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  has_scope :degree, :score, :position_type
  load_and_authorize_resource :company
  load_and_authorize_resource :valuation, through: :company
  # GET /valuations
  # GET /valuations.json
  def index
    respond_to do |format|
      @company = Company.find(params[:company_id])
      format.html {
        @position_types = PositionType.all
        @degrees = Degree.all
        @valuations = apply_scopes(Valuation).load_valuations(@company, params[:page], params[:per_page]).order(sort_column + " " + sort_direction)
      }
      format.xlsx{
        @valuations = Valuation.load_all_valuations(@company)
        ##Ajustar nombre del archivo, con nombre de la empresa y fecha del dia de descarga
        response.headers['Content-Disposition'] = 'attachment; filename="Valoraciones '+@company.name+ ' '+Time.now.strftime("%Y/%m/%d") +'.xlsx"'
       }
    end
  end

  def import
    @company = Company.find(params[:company_id])
    begin
    Valuation.import(params[:file], params[:company_id])
      redirect_to company_valuations_path(@company), notice:  "Valoraciones actualizadas"
    rescue Roo::HeaderRowNotFoundError => e
      redirect_to company_valuations_path(@company), notice:  "Error en la cabecera de excel"
    end
  end

  # GET /valuations/1
  # GET /valuations/1.json
  def show
    @company = @valuation.job_title.area.company
  end

  # GET /valuations/new
  def new
    #@areas = Company.find()
    @company = Company.find(params[:company_id])
    @areas = @company.areas
    @valuation = Valuation.new
    #@knowledge = Criterium.where(criteria_type_id: 1, position_type_id: params[:position_type_id])
    @position_types = PositionType.all
    @degrees = Degree.all
  end

  # GET /valuations/1/edit
  def edit
    @company = @valuation.job_title.area.company
    @area = @valuation.job_title.area
    @areas = @company.areas
    @job_title = @valuation.job_title
    @job_titles = @valuation.job_title.area.job_titles
    @position_type = @valuation.position_type
    @position_types = PositionType.all
    @degrees = Degree.all
  end

  # POST /valuations
  # POST /valuations.json
  def create
    @company = Company.find(params[:company_id])
    @valuation = Valuation.new(valuation_params)
    @valuation.company = @company
    puts "Valuation:"
    puts valuation_params
    puts @valuation
    respond_to do |format|
      if @valuation.save
        format.html { redirect_to company_valuations_path(@company), notice: 'Valoración fue creada exitosamente.' }
        format.json { render :show, status: :created, location: @valuation }
      else
        @areas = @company.areas
        @position_types = PositionType.all
        @degrees = Degree.all
        puts "No se logro guardar."
        #puts
        format.html { render :new }
        format.json { render json: @valuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /valuations/1
  # PATCH/PUT /valuations/1.json
  def update
    respond_to do |format|
      if @valuation.update(valuation_params)
        format.html { redirect_to @valuation, notice: 'Valoración fue actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @valuation }
      else
        format.html { render :edit }
        format.json { render json: @valuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /valuations/1
  # DELETE /valuations/1.json
  def destroy
    @valuation.destroy
    respond_to do |format|
      format.html { redirect_to valuations_url, notice: 'Valoración fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valuation
      @valuation = Valuation.find(params[:id])
    end


    def sort_column
      Valuation.column_names.concat(["job_titles.name", "position_types.name", "degrees.number"]).include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def valuation_params
      params.require(:valuation).permit(:job_title_id, :position_type_id, :knowledge_id, :skill_id, :definition_supervision_id, :risk_decision_id, :sustainability_id, :area_impact_id, :influence_id, :score, :degree_id)
    end
end
