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
  has_many :historics, dependent: :destroy

  scope :score, ->(s) {where score: s}
  scope :degree, ->(d) {where degree: d}
  scope :position_type, ->(pt) {where position_type: pt}
  scope :job_title, ->(jt) { joins(:job_title).where("job_titles.name ilike ?", '%' +jt + '%')}
  scope :area, ->(a) {where("areas.id = ?", a)}
  scope :business_unit, ->(bu) {where("business_units.id = ?", bu)}
  #  .where( "job_titles.name like ?", "#{jt}")}

  def self.load_valuations(company,page=1, per_page=20)
    joins(:degree, :company, :position_type, :job_title).joins("LEFT OUTER JOIN areas on job_titles.area_id = areas.id left outer join business_units on business_units.id = areas.business_unit_id")
      .paginate(:page => page, :per_page => per_page).where(company_id: company.id)
  end

  def self.load_all_valuations(company)
    joins(:degree, :company, :position_type, :job_title).where(company_id: company.id)
  end

  ##Import valuations record from excel, reading record by record
  def self.import(file, company_id)

    #criteria_hash = Criteria.hash_by_
    ##Variables que se van a necesitar tener cargadas de forma previa
    ## para optimizar la carga de datos
    job_titles_hash = JobTitle.job_titles_hash_by_name(company_id)
    position_types_hash = PositionType.get_hashed_by_name
    #criteria_hash = Criterium.get

    ## Operaciones con el archivo de excel
    xlsx = Roo::Excelx.new(file.path())
    #puts xlsx.info
    logger.debug "Import Valoraciones"

    hoja = xlsx.sheet('Valoración')
    i=0
    hoja.each(id: 'id', position: 'Cargo', position_type: "TipoPosición", knowledge: "Conocimiento",
      skill: "Habilidades",	supervision: "Supervisión",	risk: "Riesgos", 	sustainability: "Sostenibilidad",
      	area_impact:"Responsabilidad", 	influence: "Influencia") do |hash|
      logger.debug hash.inspect
      if hash[:id] == "id"
        next
      end
      c= nil
      if hash[:id] != nil
        c = Valuation.find(hash[:id])
      end

      if c!= nil
        #actualizar
        #g = Degree.find(hash[:degree])
        #c.update( score: hash[:score],  degree: g, description: hash[:description] )
        logger.debug "update"
      else
        logger.debug "create"
        logger.debug "Position #{i}"
        i+=1
        record = record_to_params(hash, job_titles_hash, position_types_hash)
        record.company_id = company_id
        record.save!
      end
      #Clase.create(number: hash.clase, name: hash.denominacion)
    end
  end #End import

##Makes a Valuation like a new list of params
  def self.record_to_params(hash, job_titles_hash, position_types_hash)
    valuation = Valuation.new
    valuation.score = 0
    valuation.job_title_id =  job_titles_hash[hash[:position]][:id]
    valuation.position_type_id = position_types_hash[hash[:position_type].downcase][:id]
    ## Knowledge section
    knowledge = Criterium.where(criteria_type_id: 1, position_type_id: valuation.position_type_id, score: hash[:knowledge]).first
    valuation.knowledge_id = knowledge.id
    valuation.score += knowledge.score
    ## Skill section
    skill = Criterium.where(criteria_type_id: 2, position_type_id: valuation.position_type_id, score: hash[:skill]).first
    valuation.skill_id = skill.id
    valuation.score += skill.score
    ##Definition supervision section
    definition = Criterium.where(criteria_type_id: 3, position_type_id: valuation.position_type_id, score: hash[:supervision]).first
    valuation.definition_supervision_id = definition.id
    valuation.score += definition.score
    ##Risk decision section
    risk = Criterium.where(criteria_type_id: 4, position_type_id: valuation.position_type_id, score: hash[:risk]).first
    valuation.risk_decision_id = risk.id
    valuation.score += risk.score
    ## sustainability section
    sustainability = Criterium.where(criteria_type_id: 5, position_type_id: valuation.position_type_id, score: hash[:sustainability]).first
    valuation.sustainability_id = sustainability.id
    valuation.score += sustainability.score
    ## area_impact section
    area_impact = Criterium.where(criteria_type_id: 6, position_type_id: valuation.position_type_id, score: hash[:area_impact]).first
    valuation.area_impact_id = area_impact.id
    valuation.score += area_impact.score
    ## Influence section
    influence = Criterium.where(criteria_type_id: 7, position_type_id: valuation.position_type_id, score: hash[:influence]).first
    valuation.influence_id = influence.id
    valuation.score += influence.score

    ## Get right level
    degree = Degree.where("minimum <= ? and maximun >= ? ",valuation.score, valuation.score ).first
    valuation.degree_id = degree.id
    return valuation
    ##do nothing
  end

  ##Method to_s is going to show a resume of all the fields of the object
  def to_s
    result = "Cargo: #{self.job_title.name} Rol: #{self.position_type.name}, "+
    "Amplitud y profundidad del conocimiento aplicado: #{Criterium.find( self.knowledge_id).degree.number}, "+
    "Actuación (Habilidades): #{Criterium.find( self.skill_id).degree.number}, "+
    "Definiciones y Supervisión: #{Criterium.find( self.definition_supervision_id).degree.number}, "+
    "Riesgos asumidos y nivel de decisiones: #{Criterium.find(self.risk_decision_id).degree.number}, "+
    "Sostenibilidad (Tiempo): #{Criterium.find( self.sustainability_id).degree.number}, "+
    "Area de Responsabilidad: #{Criterium.find( self.area_impact_id).degree.number}, "+
    "Influencia en los resultados: #{Criterium.find( self.influence_id).degree.number}, "+
    "Puntaje: #{self.score}, "+
    "Grado: #{self.degree.number}"

  end

end
