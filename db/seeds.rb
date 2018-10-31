# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include FactoryBot::Syntax::Methods

require 'csv'

#create(:country, number: 890, name: 'ZAMBIA')
=begin
CSV.foreach(
    "db/csv/Libro1.csv",
    { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  puts row
  Country.create(row.to_hash)
end


CSV.foreach('db/csv/Libro1.csv', col_sep: ';', converters: :numeric) {
    |row|
    puts row[0].to_s + ' '+ row[1]
  Country.create(code: row[0], name: row[1])
  }

colombia = Country.find_by_name('COLOMBIA')
puts colombia.name


CSV.foreach('db/csv/Departamentos.csv', col_sep: ';', converters: :numeric) {
   |row|
   puts row[0].to_s + ' '+ row[1]
State.create(code: row[0], name: row[1], country_id: colombia.id)
}#
#counter =0
CSV.foreach('db/csv/Cities.csv', col_sep: ';') {
    |row|
  #puts counter
  #counter+=1
  #print row[0].to_s.to_i/1000
  #print "\t"
  #puts Integer(row[0])
  state = State.find_by_code(row[0].to_s.to_i/1000)
  puts row[0].to_s + ' '+ row[1]
  next if state == nil
  City.create(code: row[0].to_s.to_i, name: row[1], state_id: state.id)
}


#f = File.open('test/xlsx/PUCTest10.xlsx', "r")
xlsx = Roo::Excelx.new('test/xlsx/PUCTest.xlsx')
    #puts xlsx.info
hoja = xlsx.sheet('PUC')
hoja.each( grupo: 'GRUPO', clase: 'CLASE',cuenta: 'CUENTA', subcuenta: 'SUB CUENTA', auxiliar: 'AUXILIAR', denominacion: "NOMBRE O DENOMINACION") do |hash|
  if hash[:clase] == "CLASE" || hash[:grupo] == "GRUPO"
    next
  end
  #puts hash[:clase].to_s + " g" + hash[:grupo].to_s + " c" + hash[:cuenta].to_s +  " d" + hash[:denominacion].to_s

  if hash[:clase] != nil && hash[:clase] != ""
    Clase.create(number: hash[:clase], name: hash[:denominacion])
  elsif   hash[:grupo] != nil && hash[:clase] != ""
    ##Comprueba si es entero y evita exception en caso de que no lo sea
    numero =Integer(hash[:grupo]) rescue nil
    ##Se chequea que los datos ingresados no sean texto
    if numero != nil
      c= Clase.find_by_number(numero/10)
      ## Se chequea que tiene un padre con ese valor
      if c != nil
        Grupo.create(number: hash[:grupo], name: hash[:denominacion], clase_id: c.id)
      end
    end
  elsif hash[:cuenta] != nil && hash[:cuenta] != ""
    numero =Integer(hash[:cuenta]) rescue nil
    if numero != nil
      g= Grupo.find_by_number(numero/100)
      if g != nil
        Account.create(number: hash[:cuenta], name: hash[:denominacion], grupo_id: g.id)
      end
    end
  elsif hash[:subcuenta] != nil && hash[:subcuenta] != ""
    numero =Integer(hash[:subcuenta]) rescue nil
    if numero != nil
      a= Account.find_by_number(numero/100)
      if a != nil
        Subaccount.create(number: hash[:subcuenta], name: hash[:denominacion],account_id: a.id)
      end
    end
  elsif hash[:auxiliar] != nil && hash[:auxiliar] != ""
    numero =Integer(hash[:auxiliar]) rescue nil
    if numero != nil
      s= Subaccount.find_by_number(hash[:auxiliar].to_s[0,6])
      if s!= nil
        Auxiliar.create(number: hash[:auxiliar], name: hash[:denominacion], subaccount_id: s.id)
      end
    end

  end

end


=end
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
Person.destroy_all
DocumentType.destroy_all
#Seeds para los tipos de documento
DocumentType.create(abbreviation: "RC", name: "Registro civil de nacimiento", code: 11)
DocumentType.create(abbreviation: "TI", name: "Tarjeta de Identidad", code: 12)
DocumentType.create(abbreviation: "CC", name: "Cédula de ciudadanía", code: 13)
DocumentType.create(abbreviation: "CE", name: "Cédula de extranjería", code: 22)
DocumentType.create(abbreviation: "NIT", name: "NIT", code: 31)
DocumentType.create(abbreviation: "PP", name: "Pasaporte", code: 41)


docT = DocumentType.find_by_code(13)
#crear usuario de administracion

p= Person.create(document_type_id: docT.id, document_number: 123456, first_name: "admin")



User.create(username: "admin", password: "123456", password_confirmation:"123456", person_id:p.id)
#f.close
