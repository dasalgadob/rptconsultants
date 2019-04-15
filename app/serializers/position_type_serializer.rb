class PositionTypeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :minimum_degree, :maximum_degree
end
