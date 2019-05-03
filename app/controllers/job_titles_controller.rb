class JobTitlesController < ApplicationController
  before_action :set_job_title, only: [:show, :edit, :update, :destroy]
  #load_and_authorize_resource
  load_and_authorize_resource :area
  load_and_authorize_resource :job_title, through: :area, shallow: true
  load_and_authorize_resource :company
  load_and_authorize_resource :job_title, through: :company

  skip_authorize_resource :only => [:index, :new]
  skip_authorize_resource :post, :only => [:index, :new]
  # GET /job_titles
  # GET /job_titles.json
  def index
    respond_to do |format|
      puts "params[:area_id]"   +"end"
      puts(params[:area_id]==nil)
      if params[:area_id] != nil && params[:area_id] != ""
        @job_titles = JobTitle.where(area_id: params[:area_id])
        format.html
        json_string = JobTitleSerializer.new(@job_titles).serialized_json
        format.json {render json: json_string}
      else
        @company = Company.find(params[:company_id])
          @job_titles = JobTitle.where(company_id: params[:company_id])
          format.html
          json_string = JobTitleSerializer.new(@job_titles).serialized_json
          format.json {render json: json_string}
      end
    end

  end

  # GET /job_titles/1
  # GET /job_titles/1.json
  def show
  end

  # GET /job_titles/new
  def new
    if params[:area_id]
      @area = Area.find(params[:area_id])
      @company = @area.company
    else
      @area = nil
      @company = Company.find(params[:company_id])
    end
    @areas = Area.where(company: @company)
    @job_title = JobTitle.new
    @job_title.company = @company
    @job_title.area = @area
  end

  # GET /job_titles/1/edit
  def edit
    @company = @job_title.company
    ##Area is not passed to avoid damaging the automatic url
    @areas = Area.where(company_id: @company.id)
  end

  # POST /job_titles
  # POST /job_titles.json
  def create
    @job_title = JobTitle.new(job_title_params)

    @area = @job_title.area
    @company = @job_title.company
    @areas = Area.where(company_id: @company.id)
    @job_title.area = @area
    respond_to do |format|
      if @job_title.save
        format.html { redirect_to @job_title.area ? @job_title.area : @job_title, notice: 'Cargo fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @job_title }
      else
        format.html { render :new }
        format.json { render json: @job_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_titles/1
  # PATCH/PUT /job_titles/1.json
  def update
    @company = @job_title.company
    @areas = Area.where(company_id: @company.id)
    respond_to do |format|
      if @job_title.update(job_title_params)
        format.html { redirect_to @job_title.area ? @job_title.area: @job_title, notice: 'Cargo fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @job_title }
      else
        format.html { render :edit }
        format.json { render json: @job_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_titles/1
  # DELETE /job_titles/1.json
  def destroy
    @area = @job_title.area
    @company = @job_title.company
    @job_title.destroy
    respond_to do |format|
      format.html { redirect_to company_job_titles_path(@company), notice: 'Cargo fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_title
      @job_title = JobTitle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_title_params
      params.require(:job_title).permit(:name, :area_id, :company_id)
    end
end
