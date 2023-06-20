# frozen_string_literal: true

class Menu < ApplicationRecord
  has_many :order_details
  belongs_to :flower_shop

  validates :name, :price, :flower_shop_id, presence: true

  scope :cheapest, -> { order(price: :asc).first }

  def name_with_price
    "#{name}(#{price}円)"
  end
end
