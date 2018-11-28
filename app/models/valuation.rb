class Valuation < ApplicationRecord
  belongs_to :job_title
  #belongs_to :area, through: :job_title
  belongs_to :position_type
  belongs_to :knowledge, class_name: "Criterium"
  belongs_to :skill, class_name: "Criterium"
  belongs_to :definition_supervision, class_name: "Criterium"
  belongs_to :risk_decision, class_name: "Criterium"
  belongs_to :sustainability, class_name: "Criterium"
  belongs_to :area_impact, class_name: "Criterium"
  belongs_to :influence, class_name: "Criterium"
  belongs_to :degree
  belongs_to :company

  scope :score, ->(s) {where score: s}
  scope :degree, ->(d) {where degree: d}
  scope :position_type, ->(pt) {where position_type: pt}

  def self.load_valuations(company,page=1, per_page=20)
    joins(:degree, :company, :position_type, :job_title)
      .paginate(:page => page, :per_page => per_page).where(company_id: company.id)
  end


  def self.import(file, company_id)

    #criteria_hash = Criteria.hash_by_
    ##Variables que se van a necesitar tener cargadas de forma previa
    ## para optimizar la carga de datos
    job_titles_hash = JobTitle.job_titles_hash_by_name(company_id)


    ## Operaciones con el archivo de excel
    xlsx = Roo::Excelx.new(file.path())
    #puts xlsx.info
    logger.debug "Import Valoraciones"

    hoja = xlsx.sheet('Valoración')
    hoja.each(id: 'id', position: 'Cargo', position_type: "TipoPosición", knowledge: "Conocimiento",
      skill: "Habilidades",	supervision: "Supervisión",	risk: "Riesgos", 	sustainability: "Sostenibilidad",
      	area_impact:"Responsabilidad", 	influence: "Influencia") do |hash|
      logger.debug hash.inspect
      if hash[:id] == "id"
        next
      end
      c = Valuation.find(hash[:id])
      if c!= nil
        #actualizar
        #g = Degree.find(hash[:degree])
        #c.update( score: hash[:score],  degree: g, description: hash[:description] )
        logger.debug "update"
      else
        logger.debug "create"
        #jt = JobTitle.where(company_id: company_id)
        jt = JobTitle.joins(area: :company).where("companies.id": company_id,
           name: hash[:position]).first
        pt = PositionType.where(name: hash[:position_type].downcase)
        #Valuation.create()
      end
      #Clase.create(number: hash.clase, name: hash.denominacion)
    end
  end #End import

end
