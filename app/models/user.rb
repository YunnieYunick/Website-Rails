class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :username, presence: true, length: { maximum: 50 }
  validates :role, presence: true
  enum role: { admin: 0, member: 1 }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, :default_url => "/assets/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
