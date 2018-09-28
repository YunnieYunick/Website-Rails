class Dashboard < ApplicationRecord
  validates :site_name, presence: true
  validates :site_description, presence: true
end
