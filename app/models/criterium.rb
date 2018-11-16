class Criterium < ApplicationRecord
  belongs_to :degree
  belongs_to :position_type
  scope :score, ->(s) {where score: s}
  scope :degree, -> (d) {where degree_id: d}
  scope :criteria_type_id,-> (c) {where criteria_type_id: c}
  scope :position_type_id, -> (p) { where position_type_id: p }

  def self.load_criteria(page=1, per_page=20)
    includes(:degree, :position_type)
      .paginate(:page => page, :per_page => per_page)
  end


  def self.import(file)
    xlsx = Roo::Excelx.new(file.path())
    #puts xlsx.info
    hoja = xlsx.sheet('Criteria')
    hoja.each(id: 'id', score: 'Puntaje',  degree: 'Grado', criteria_type: "TipoCriterio", position_type: "TipoPosición", description: "Descripción") do |hash|
      logger.debug hash.inspect
      if hash[:id] == "id"
        next
      end
      c = Criterium.find(hash[:id])
      if c!= nil
        #actualizar
        g = Degree.find(hash[:degree])
        c.update( score: hash[:score],  degree: g, description: hash[:description] )
        logger.debug "update"
      else
        logger.debug "create"
      end
      #Clase.create(number: hash.clase, name: hash.denominacion)
    end
  end #End import

end #End Class
