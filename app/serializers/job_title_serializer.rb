class JobTitleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :area_id
end
