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
        can [:read], Order, user_id: user.id
        can [:place, :edit_address, :edit_payment, :edit_delivery, :confirm, :update], Order do |order|
          order.aasm_state == :in_progress.to_s
          order.user == user
        end
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
