class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    can :read, :all
    if user and user.role.user?
        can :create, Ad
        can [:update,:ready], Ad do |article|
            article.user==user and article.draft?
        end
        can [:destroy], Ad do |article|
            article.user==user
        end
        can [:draft], Ad do |article|
            article.user==user and (article.reject? or article.archive?)
        end
    elsif user and user.role.admin?
        can :manage, Section
        can [:destroy], Ad
        can [:reject,:approve], Ad do |article|
            article.ready?
        end
    end
  end
end
