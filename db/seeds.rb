#include FactoryBot::Syntax::Methods

require 'csv'
c = Company.first
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
    JobTitle.create(name: hash[:cargo], area_id: a.id, company_id: c.id)
  end
end
