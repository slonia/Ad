class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Ad

    if user && user.role.user?
        can [:create,:manager], Ad
        can [:update,:ready], Ad do |article|
            article.user==user && article.draft?
        end
        can [:destroy], Ad do |article|
            article.user==user
        end
        can [:draft], Ad do |article|
            article.user_id==user.id && (article.reject? or article.archive?)
        end
        can [:update], User do |u|
            u.id==user.id
        end
    elsif user && user.role.admin?
        can :read, :all
        can [:create, :update], Section
        can [:destroy], Section do |section|
            Ad.find_all_by_section_id(section.id).empty?
        end
        can [:destroy,:manager], Ad
        can [:reject,:approve], Ad do |article|
            article.ready?
        end
        can [:update, :create], User
        can [:destroy,:assign_role], User do |u|
            u.id!=user.id
        end
    end

  end

end
