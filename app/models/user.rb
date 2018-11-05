class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :display_name, :first_name, :last_name

  has_many :articles

  has_many :assignments
  has_many :roles, through: :assignments
end
