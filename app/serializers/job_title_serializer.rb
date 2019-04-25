class JobTitleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
  attribute  :area_id
end
