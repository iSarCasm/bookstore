class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard              # grant access to the dashboard
    else
      if user.id
        can [:index, :show], Order, user_id: user.id
        can :manage, User, id: user.id
        can :create, Review
      end
      can :read, Author
      can :read, Book
      can :show, Category
      can :read, Review
    end
  end
end
