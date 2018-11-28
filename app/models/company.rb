class Company < ApplicationRecord
  has_many :areas
  has_many :valuations

  validates :name, presence: true
end
