class Menu < ApplicationRecord
  belongs_to :flower_shop

  validates :name, :price, :flower_shop_id, presence: true
end
