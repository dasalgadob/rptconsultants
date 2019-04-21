module AreasHelper
  def get_business_unit_string(area)
    return area.business_unit == nil ? area.company.name : area.business_unit.name
  end
end
