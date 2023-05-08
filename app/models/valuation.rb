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

  def get_degrees_range
    if score <= degree.median
      "Bajo"
    else
      "Alto"
    end
  end

  
  def who_score
    knowledge.score + skill.score
  end

  def how_score
    definition_supervision.score + risk_decision.score
  end

  def what_score
    sustainability.score + area_impact.score + influence.score
  end

  def what_vs_how
    if how_score == 0
      0
    else
      (what_score.to_f / how_score).round(2)
    end
  end

  def profile
    if what_vs_how <= 0.89
      -1
    elsif what_vs_how <= 1.1
      0
    elsif what_vs_how <= 1.2
      1
    elsif what_vs_how <= 1.4
      2
    elsif what_vs_how <= 1.55
      3
    else
      4
    end
  end

  def self.load_valuations(company,page=1, per_page=20)
    joins(:degree, :company, :position_type, :job_title).joins("LEFT OUTER JOIN areas on job_titles.area_id = areas.id left outer join business_units on business_units.id = areas.business_unit_id")
      .paginate(:page => page, :per_page => per_page).where(company_id: company.id)
  end

  def self.load_all_valuations(company)
    joins(:company)
      .includes(:degree, :job_title, :position_type, :knowledge, :skill, :definition_supervision, :risk_decision, :sustainability, :area_impact, :influence)
      .where(company_id: company.id)
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

  ##Sanitiza sql executed directly to the database NOT build by ActiveRecord
  def self.execute_sql(*sql_array)
   connection.execute(send(:sanitize_sql_array, sql_array))
  end

  ##Function that return a hash that has as the key the area_id,
  ## and its values are
  ##count_high: Number of valuations for the company_id, with degree_id for the higher range
  ##records: The records of that area_id
  ## No element to the resulting hash is added if there area no records for that area
  def self.get_hash_records_by_degree_range_high(degree_id, company_id)
    result = execute_sql("
    select job_titles.area_id,
    count(job_titles.area_id) filter(where valuations.score between degrees.median + 1 and degrees.maximun ) as count_high
    from valuations
    join job_titles on  job_titles.id = valuations.job_title_id
    join degrees on valuations.degree_id = degrees.id
    where valuations.degree_id=? and valuations.company_id =?
    group by job_titles.area_id",degree_id, company_id )
    result_hash = {}
    result.each{
      |r|
      if r["count_high"]>0 then
        result_hash[r["area_id"]]=
            ##Second term of the hash it hash the count and the records that were returned
            [r["count_high"],
             Valuation
             .joins("join job_titles on valuations.job_title_id = job_titles.id
                     join degrees on valuations.degree_id = degrees.id")
             .where(" area_id = ? and valuations.company_id=? and degree_id = ?
                     and valuations.score between degrees.median + 1 and degrees.maximun ",
                      r["area_id"], company_id, degree_id).order(score: :desc) ]
      end
    }
    return result_hash
  end

  ##Function that return a hash that has as the key the area_id,
  ## and its values are
  ##count_high: Number of valuations for the company_id, with degree_id for the higher range
  ##records: The records of that area_id
  ## No element to the resulting hash is added if there area no records for that area
  def self.get_hash_records_by_degree_range_low(degree_id, company_id)
    result = execute_sql("
    select job_titles.area_id,
    count(job_titles.area_id) filter(where valuations.score between degrees.minimum and degrees.median ) as count_low
    from valuations
    join job_titles on  job_titles.id = valuations.job_title_id
    join degrees on valuations.degree_id = degrees.id
    where valuations.degree_id=? and valuations.company_id =?
    group by job_titles.area_id",degree_id, company_id )
    result_hash = {}
    result.each{
      |r|
      if r["count_low"]>0 then
        result_hash[r["area_id"]]=
            ##Second term of the hash it hash the count and the records that were returned
            [r["count_low"],
             Valuation
             .joins("join job_titles on valuations.job_title_id = job_titles.id
                     join degrees on valuations.degree_id = degrees.id")
             .where(" area_id = ? and valuations.company_id=? and degree_id = ?
                     and valuations.score between degrees.minimum and degrees.median ",
                      r["area_id"], company_id, degree_id).order(score: :desc) ]
      end
    }
    return result_hash
  end

  ##Method to_s is going to show a resume of all the fields of the object
  def to_s
    result = "Cargo: #{self.job_title.name} Rol: #{self.position_type.name}, <br>"+
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

  #Methods of the class
  class <<self
    ##This methods returns two string in an array
    ##The first one get the field with its values before they were altered
    ##The second element of the array gets just the new values that were changed
    def get_changed_values(valuation_old, valuation_new)
      result_old=""
      result_new =""
      if valuation_old.job_title_id != valuation_new.job_title_id
        result_old+= "Cargo: #{valuation_old.job_title.name}<br>"
        result_new+= "Cargo: #{valuation_new.job_title.name}<br>"
      end
      if valuation_old.position_type_id != valuation_new.position_type_id
        result_old+= "Rol: #{valuation_old.position_type.name}<br>"
        result_new+= "Rol: #{valuation_new.position_type.name}<br>"
      end
      if valuation_old.knowledge_id != valuation_new.knowledge_id
        result_old+= "Amplitud y profundidad del conocimiento aplicado: #{Criterium.find( valuation_old.knowledge_id).degree.number}<br>"
        result_new+= "Amplitud y profundidad del conocimiento aplicado: #{Criterium.find( valuation_new.knowledge_id).degree.number}<br>"
      end
      if valuation_old.skill_id != valuation_new.skill_id
        result_old+= "Actuación (Habilidades): #{Criterium.find( valuation_old.skill_id).degree.number}<br>"
        result_new+= "Actuación (Habilidades): #{Criterium.find( valuation_new.skill_id).degree.number}<br>"
      end
      if valuation_old.definition_supervision_id != valuation_new.definition_supervision_id
        result_old+= "Definiciones y Supervisión: #{Criterium.find( valuation_old.definition_supervision_id).degree.number}<br>"
        result_new+= "Definiciones y Supervisión: #{Criterium.find( valuation_new.definition_supervision_id).degree.number}<br>"
      end
      if valuation_old.risk_decision_id != valuation_new.risk_decision_id
        result_old+= "Riesgos asumidos y nivel de decisiones: #{Criterium.find( valuation_old.risk_decision_id).degree.number}<br>"
        result_new+= "Riesgos asumidos y nivel de decisiones: #{Criterium.find( valuation_new.risk_decision_id).degree.number}<br>"
      end
      if valuation_old.sustainability_id != valuation_new.sustainability_id
        result_old+= "Sostenibilidad (Tiempo): #{Criterium.find( valuation_old.sustainability_id).degree.number}<br>"
        result_new+= "Sostenibilidad (Tiempo): #{Criterium.find( valuation_new.sustainability_id).degree.number}<br>"
      end
      if valuation_old.area_impact_id != valuation_new.area_impact_id
        result_old+= "Area de Responsabilidad: #{Criterium.find( valuation_old.area_impact_id).degree.number}<br>"
        result_new+= "Area de Responsabilidad: #{Criterium.find( valuation_new.area_impact_id).degree.number}<br>"
      end
      if valuation_old.influence_id != valuation_new.influence_id
        result_old+= "Influencia en los resultados: #{Criterium.find( valuation_old.influence_id).degree.number}<br>"
        result_new+= "Influencia en los resultados: #{Criterium.find( valuation_new.influence_id).degree.number}<br>"
      end
      if valuation_old.score != valuation_new.score
        result_old += "Puntaje: #{valuation_old.score}<br>"
        result_new += "Puntaje: #{valuation_new.score}<br>"
      end
      if valuation_old.degree_id != valuation_new.degree_id
        result_old += "Grado: #{valuation_old.degree.number}<br>"
        result_new += "Grado: #{valuation_new.degree.number}<br>"
      end
      return [result_old, result_new]
    end##End comparison function

  end#End class methods

end
