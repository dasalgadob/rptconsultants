class PositionType < ApplicationRecord
  has_many :criteria
  #scope :name, -> (n) {where name: n}
  scope :by_name, -> name { where(name: name) }

  validates :name, presence: true

  def self.get_hashed_by_name()
    rs = PositionType.all
    pth = {}
    rs.each{|pt| pth[pt[:name]] = pt }
    pth
  end
end
