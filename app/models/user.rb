class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :display_name, :first_name, :last_name

  has_many :articles

  has_many :assignments
  has_many :roles, through: :assignments

  def role?(role, entity_id = nil)
    if entity_id.present?
      roles.where(entity_id: entity_id, name: role).any?
    else
      logger.warn "Role check used without an entity id presented #{role} called for #{id} user"
      roles.any? {|r| r.name.to_sym == role}
    end
  end
end
