class Historic < ApplicationRecord
  belongs_to :user
  belongs_to :valuation

  ##Make comparisons between the old and new fields to determined which string use
  #in the field clase
  def set_clase_string(old_review, old_approve, new_review, new_approve)
    result = ""
    if old_review != new_review && new_review == true
      result = "Revisión"
    end
    if old_approve != new_approve && new_approve == true
      if result.length>0
        result +=' y '
      end
      result += "Aprobación"
    end
    if result.length==0
      result = "Actualización"
    end
    return result
  end##End of function

end ## End of class
