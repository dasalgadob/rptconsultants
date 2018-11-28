class PositionType < ApplicationRecord
  has_many :criteria
  #scope :name, -> (n) {where name: n}
  scope :by_name, -> name { where(name: name) }

  validates :name, presence: true
end
