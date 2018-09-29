class Category < ApplicationRecord
  has_many :posts

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end
end
