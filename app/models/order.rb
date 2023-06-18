class Order < ApplicationRecord
  has_many :order_details
  belongs_to :company
  belongs_to :flower_shop
end
