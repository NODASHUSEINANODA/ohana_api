# frozen_string_literal: true

class Menu < ApplicationRecord
  extend Enumerize

  has_many :order_details
  belongs_to :flower_shop

  validates :name, :price, :flower_shop_id, :season, presence: true

  scope :cheapest, -> { order(price: :asc).first }
  scope :season_menu, lambda {
    spring_term = [2, 3, 4]
    summer_term = [5, 6, 7]
    automn_term = [8, 9, 10]
    winter_term = [11, 12, 1]

    case Time.now.month
    when *spring_term
      where(season: :spring)
    when *summer_term
      where(season: :summer)
    when *automn_term
      where(season: :automn)
    when *winter_term
      where(season: :winter)
    else
      all
    end
  }

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
