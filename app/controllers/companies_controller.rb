class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :report_matrix_simple, :report_matrix_complex, :map_detailed]
  load_and_authorize_resource

  def report_matrix_simple
    @valuations = Valuation.where(company_id: @company.id).order(:degree_id, score: :desc )
    @areas = Area.where(company_id: @company.id).order(:name)
    #@areas_hash = Area.area_hash_by_name(@company.id)
  end

  def map_detailed
    @degrees = Degree.order(number: :desc)
    @valuations = Valuation.where(company_id: @company.id).order(:degree_id, score: :desc )
    @areas = Area.where(company_id: @company.id).order(:name)
    #@areas_hash = Area.area_hash_by_name(@company.id)
  end

  def reports
  end
  # GET /companies
  # GET /companies.json
  def index
    #### Just the admin receives all the companies available, otherwise just the own company is retorned
    if current_user.is_admin?
      @companies = Company.all
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @tz = TZInfo::Timezone.get('America/Bogota')
    if !current_user.is_admin?  && @company.access_expire_date < Time.now.utc
      #mostrar index y enviar mensaje de notice
      redirect_to companies_path, notice: "Fecha de acceso a la herramienta expiro el #{@tz.utc_to_local(@company.access_expire_date).strftime("%d/%m/%Y")}, pongase en contacto con soporte para seguir teniendo acceso."
    end

  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Empresa fue creada exitosamente.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Empresa fue actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Empresa fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :access_expire_date)
    end
end
