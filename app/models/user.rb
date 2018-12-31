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

  USER_ROLES = %w(guest member writer admin).freeze

  USER_ROLES.each do |role|
    define_method("#{role}?") { has_role?(role) }
  end

	def set_default_role
    self.is_a?(GuestUser) ? assign_role("guest") : assign_role("member")
	end

  def assign_role role
    self.roles << Role.find_by_name("#{role}") unless has_role? role
  end

  def user_roles
    self.roles.map(&:name)
  end

  def has_role? role
    user_roles.include? role.to_s
  end

  def self.all_roles
    USER_ROLES
  end
end
