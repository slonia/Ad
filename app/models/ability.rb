class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.role.user?
      can [:create], Ad
      can [:update, :ready], Ad, user_id: user.id, state: ['draft']
      can [:read, :manager, :destroy], Ad, user_id: user.id
      can [:draft], Ad, user_id: user.id, state: ['reject', 'archive']
      can [:update], User, id: user.id
    elsif user && user.role.admin?
      can [:read], :all
      can [:create, :update], Section
      can([:destroy], Section) { |section| section.ads.empty? }
      can [:manager,:destroy], Ad
      cannot [:manager,:destroy], Ad, state: ['draft']
      can [:reject, :approve], Ad, state: ['ready']
      can [:update, :create], User
      can [:destroy, :assign_role], User
      cannot [:destroy, :assign_role], User, :id=>user.id
    else
      can [:read], Ad, state: [:publish]
    end
  end

end
