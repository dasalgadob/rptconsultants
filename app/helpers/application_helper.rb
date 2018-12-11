module ApplicationHelper
  def sortable(column, title = nil, params= nil)
  title ||= column.titleize
  logger.debug "sortable helper. Column: " + column + " sort_column: " + sort_column
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  logger.debug "Params: "
  logger.debug params
  parameters = {:sort => column, :direction => direction}
  if params != nil
    params.each do |key, value|
      if key != 'sort' && key != 'direction'
          parameters[key]= value
      end#end if
    end# end each
  end #end if
  link_to title, parameters, {:class => css_class}
end #end sortable

end
