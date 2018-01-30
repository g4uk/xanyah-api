class Ability
  include CanCan::Ability

  include CategoryAbility
  include ManufacturerAbility
  include ProductAbility
  include ProviderAbility
  include StoreAbility
  include StoreMembershipAbility
  include VariantAbility

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, to: :cru

    category_ability user
    manufacturer_ability user
    product_ability user
    provider_ability user
    store_ability user
    store_membership_ability user
    variant_ability user
  end
end
