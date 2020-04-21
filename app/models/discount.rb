class Discount <ApplicationRecord

  belongs_to :item

  validates_presence_of :description,
                        :discount_amount,
                        :minimum_quantity

validates_numericality_of :discount_amount, less_than: 1
validates_numericality_of :minimum_quantity, greater_than: 0

  def adjusted_item_price
    discount = item.price * discount_amount
    item.price - discount
  end

  def discounted_subtotal(cart)
    adjusted_item_price * cart.contents[item.id.to_s]
  end
end
