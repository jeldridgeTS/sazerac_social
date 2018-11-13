class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :display_name, :first_name, :last_name

  has_many :articles
  has_many :assignments
  has_many :roles, through: :assignments

  after_initialize :set_default_role, :if => :new_record?

	def set_default_role
    unless self.user_roles.include? "member"
      self.roles << Role.find_by_name("member")
    end
	end

  def user_roles
    self.roles.map(&:name)
  end

  def has_role? role
    user_roles.include? role
  end
end
