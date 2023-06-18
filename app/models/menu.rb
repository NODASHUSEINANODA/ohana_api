class Menu < ApplicationRecord
  has_many :order_details
  belongs_to :flower_shop

  validates :name, :price, :flower_shop_id, presence: true
end
