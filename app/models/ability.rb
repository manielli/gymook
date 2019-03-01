class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    alias_action(:create, :edit, :update, :delete, to: :crud)

    can(:crud, GymClass) do |gym_class|
      user.role == "Coach" || user.admin?
    end

    can(:crud, Occurence) do |occurence|
      user.role == "Coach" || user.admin?
    end

    can(:crud, Booking) do |booking|
      booking.user == user || user.role == "Coach" || user.admin?
    end

    can(:book, Occurence) do |occurence|
      (user.persisted? && occurence.user != user) || user.admin?
    end

    can(:crud, User) do |user|
      user.role == "Coach" || user.admin?
    end

    can(:archive, Booking) do |booking|
      user.role == "Coach" || user.admin?
    end

    can(:activate, Booking) do |booking|
      user.role == "Coach" || user.admin?
    end

    can(:archive, Occurence) do |occurence|
      user.role == "Coach" || user.admin?
    end

    can(:activate, Occurence) do |occurence|
      user.role == "Coach" || user.admin?
    end
  end
end
