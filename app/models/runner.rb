class Runner < ApplicationRecord
  belongs_to :user, -> { where "status = ?", 'runn' }
  has_many :orders
end
