class DegreeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :number, :minimum, :maximun
end
