module ValuationsHelper

  #Determine if a valuation can be edited based on the user that is accessing the app
  def editable_valuation
    if !@valuation.new_record?
      ##Check if current_user has the role of the state of the valuation
      ## Just reading permission if it doesn't have any role
      ##If the current user is admin or has permission to evaluate always it can change valuations
      if current_user.approve || current_user.is_admin
        return true
      ##When user has permission to review but the valuation is not approve yet.
      elsif current_user.review && !@valuation.approve
        return true
      elsif current_user.evaluate && !@valuation.review
        return true
      else
        return false
      end
    ## It it is a new record it allows it to be created
    else
      return true
    end
  end#End function

  ##Determine the number of columns based on if it has permission to approve and review
  def number_of_columns
    n_columns =3
    if current_user.review || current_user.is_admin
      n_columns+=1
    end
    if current_user.approve || current_user.is_admin
      n_columns+=1
    end
    return n_columns
  end#end of function

  #return the string or null if there is no area for the job_title
  def get_valuation_area_string(valuation)
    return valuation.job_title.area == nil ? "" :  valuation.job_title.area.name
  end

end ##End module
