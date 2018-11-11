class Company < ApplicationRecord
  has_many :areas
  has_many :valuations
end
