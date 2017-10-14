class Work < ApplicationRecord
  belongs_to :store
  has_many :users, through: :jobs
  has_many :jobs, dependent: :destroy

  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
end
