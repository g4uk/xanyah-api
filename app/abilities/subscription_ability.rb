# frozen_string_literal: true

module SubscriptionAbility
  def subscription_ability(user)
    can :manage, Subscription do |subscription|
      subscription.store.owners.include?(user)
    end
  end
end
