class Order < ApplicationRecord
  belongs_to :company
  belongs_to :flower_shop
end
