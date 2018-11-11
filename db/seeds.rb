include FactoryBot::Syntax::Methods

require 'csv'

Valuation.destroy_all
Criterium.destroy_all
Role.destroy_all
PositionType.destroy_all
Degree.destroy_all

xlsx = Roo::Excelx.new('test/xlsx/tablas_referencia.xlsx')
## Se agrega hoja de grados
hoja = xlsx.sheet('grado')

hoja.each( grado: 'grado', minimo: 'minimo',medio: 'medio', maximo: 'maximo') do |hash|
  if hash[:grado] == "grado" || hash[:minimo] == "minimo"
    next
  end

  if hash[:grado] != nil && hash[:grado] != ''
    #puts "values"
    puts  hash[:grado].to_s + " " + hash[:minimo].to_s + " " + hash[:medio].to_s + " " + hash[:maximo].to_s
    #puts "after"
    Degree.create(number: hash[:grado], minimum: hash[:minimo], median: hash[:medio], maximun: hash[:maximo])
  end

end





PositionType.create(name: "apoyo administrativo")
PositionType.create(name: "asistenciales")
PositionType.create(name: "profesionales")
PositionType.create(name: "especialista")
PositionType.create(name: "supervision")
PositionType.create(name: "gerencia")
PositionType.create(name: "alta direccion")
PositionType.create(name: "primer directivo")

#=begin

#xlsx = Roo::Excelx.new('test/xlsx/tablas_referencia.xlsx')

hoja = xlsx.sheet('roles')

hoja.each( grado: 'grado', abb: 'abb',rol: 'rol', tipo_rol: 'tipo_rol') do |hash|
  if hash[:grado] == "grado"
    next
  end

  if hash[:grado] != nil && hash[:grado] != ''
    grado = Degree.find_by_number(hash[:grado])
    tipo_posicion = PositionType.find_by_name(hash[:tipo_rol].downcase)
    puts "values"
    puts grado.number.to_s + " " + tipo_posicion.id.to_s
    puts "after"
    puts  hash[:grado].to_s + " " + hash[:abb].to_s + " " + hash[:rol].to_s + " " + hash[:tipo_rol].to_s
    Role.create(position_type_id: tipo_posicion.id, name: hash[:rol], abbreviation: hash[:abb], degree_id: grado.id)
  end

end
#=end

#xlsx = Roo::Excelx.new('test/xlsx/tablas_referencia.xlsx')
#### Import of Criteria
hoja = xlsx.sheet('criterio')

hoja.each( score: 'puntaje', tipo: 'tipo', degree: 'degree',description: 'description', position_type: 'position_type', tipo_id: 'tipo_id') do |hash|
  if hash[:score] == "puntaje"
    next
  end

  if hash[:score] != nil && hash[:score] != ''
    grado = Degree.find_by_number(hash[:degree])
    tipo_posicion = PositionType.find_by_name(hash[:position_type].downcase)
    puts grado.number.to_s + " " + tipo_posicion.id.to_s
    puts  hash[:score].to_s + " " + hash[:tipo].to_s + " " + hash[:description].to_s + " " + hash[:position_type].to_s
    Criterium.create(criteria_type: hash[:tipo], criteria_type_id: hash[:tipo_id], score: hash[:score], degree_id: grado.id, description: hash[:description], position_type_id: tipo_posicion.id)
  end

end

User.destroy_all
User.create(username: "admin", password: "123456", password_confirmation:"123456")
#f.close
JobTitle.destroy_all
Area.destroy_all
Company.destroy_all


c = Company.create(name: "ITAÚ CORPBANCA COLOMBIA S.A.")
xlsx = Roo::Excelx.new('test/xlsx/itau.xlsx')
hoja = xlsx.sheet('area')
hoja.each(area: "area", cargo: "cargo") do |hash|
  if hash[:area]=='area'
    next
  end

  if hash[:area] != nil && hash[:area] != "" && hash[:cargo] != nil && hash[:cargo] != ""
    #Crear area si no existe
    a = Area.where(name: hash[:area])
    if a
      a = a.first
    end
    if a == nil
      a = Area.create(name: hash[:area], company_id: c.id)
    end
    #Crear Position type con el area indicada
    JobTitle.create(name: hash[:cargo], area_id: a.id)
  end
end
