class Role < ApplicationRecord
  belongs_to :degree
  belongs_to :position_type
  validates :name, presence: true
end
