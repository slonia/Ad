class User < ActiveRecord::Base
	extend Enumerize
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true, uniqueness: true
  # Setup accessible (or protected) attributes for your model
  attr_accessor :login
  attr_accessible :login,:name, :email,:phone, :password, :password_confirmation, :remember_me, :role
  enumerize :role, in: [:user, :admin], default: :user
  has_many :ads
  protected
  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
end
