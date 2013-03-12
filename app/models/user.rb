class User < ActiveRecord::Base
	extend Enumerize

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, uniqueness: true

  attr_accessible :name, :email,:phone, :password, :password_confirmation,:current_password, :remember_me

  enumerize :role, in: [:user, :admin], default: :user

  has_many :ads

  before_destroy :destroy_draft_ads

  protected

  def destroy_draft_ads
    @ads=self.ads.with_state(:draft)
    @ads.map(&:destroy)
  end

end
