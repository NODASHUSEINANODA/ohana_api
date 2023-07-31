# frozen_string_literal: true

class Menu < ApplicationRecord
  has_many :order_details
  belongs_to :flower_shop

  validates :name, :price, :flower_shop_id, :season, presence: true

  scope :cheapest, -> { order(price: :asc).first }

  enumerize :season, in: {
    spring: 1,
    summer: 2,
    automn: 3,
    winter: 4
  }, scope: true

  def name_with_price
    "#{name}(#{price}円)"
  end
end
