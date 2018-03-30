class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, length: { maximum: 50 }
  validates :address, length:{ maximum: 30 }
  validates :phone, length:{ maximum: 11 }, uniqueness: true
end
