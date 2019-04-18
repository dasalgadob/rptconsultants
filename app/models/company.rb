class Company < ApplicationRecord
  has_many :areas
  has_many :valuations
  has_many :job_titles

  validates :name, presence: true
end
