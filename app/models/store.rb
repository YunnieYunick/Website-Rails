class Store < ApplicationRecord
  has_many :works, dependent: :destroy
  validates :name, presence: true
end
