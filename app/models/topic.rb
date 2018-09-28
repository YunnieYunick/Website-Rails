class Topic < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged
end
