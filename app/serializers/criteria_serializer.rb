class CriteriaSerializer
  include FastJsonapi::ObjectSerializer
  #belongs_to :degree
  attributes :id, :score, :position_type, :criteria_type, :criteria_type_id, :degree, :description
end
