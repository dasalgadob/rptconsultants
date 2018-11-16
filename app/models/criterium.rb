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
    hoja = xlsx.sheet('criteria')
    hoja.each(clase: 'CLASE', grupo: 'GRUPO',  cuenta: 'CUENTA', denominacion: "NOMBRE O DENOMINACION") do |hash|
      puts hash.inspect
      numero =Integer(clase) rescue nil
      if hash.clase!= nil &&  numero != nil
        puts hash.inspect
        #Clase.create(number: hash.clase, name: hash.denominacion)
      #elsif grupo != nil
      end
      # => { id: 1, name: 'John Smith' }
    end
  end
end
