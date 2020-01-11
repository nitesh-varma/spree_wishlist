module Spree::UserDecorator
  def self.prepended(base)
    base.has_many :wishlists, class_name: Spree::Wishlist.name
    base.has_many :wished_products, through: :wishlists
  end

  def wishlist
    default_wishlist = wishlists.where(is_default: true).first
    default_wishlist ||= wishlists.first
    default_wishlist ||= wishlists.create(name: Spree.t(:default_wishlist_name), is_default: true)
    default_wishlist.update_attribute(:is_default, true) unless default_wishlist.is_default?
    default_wishlist
  end

  def wished_products_count
    @wished_products_count ||= wished_products.count
  end
end

Spree.user_class.prepend Spree::UserDecorator
