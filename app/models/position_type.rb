class PositionType < ApplicationRecord

  #scope :name, -> (n) {where name: n}
  scope :by_name, -> name { where(name: name) }
end
