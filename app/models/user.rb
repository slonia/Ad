class User < ActiveRecord::Base
	extend Enumerize
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true, uniqueness: true
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email,:phone, :password, :password_confirmation,:current_password, :remember_me, :role
  enumerize :role, in: [:user, :admin], default: :user
  has_many :ads
  before_destroy :destroy_draft_ads

  protected
  def destroy_draft_ads
    @ads = Ad.with_state('draft').find_all_by_user_id(self.id)
    @ads.each{ |ad| ad.destroy }
  end

end
