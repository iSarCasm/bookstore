class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.news

    if user.admin
      can :manage, :all
    else
      if user.id
        can [:index, :show], Order, user_id: user.id
        can :manage, User, id: user.id
        can [:create], Review
      end
      can :read, Book
      can :show, Category
      can :read, Review, approved: true
    end
  end
end
