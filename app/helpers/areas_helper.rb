module AreasHelper
  def get_area_business_unit_string(area)
    return area.business_unit == nil ? "" : area.business_unit.name
  end
end
