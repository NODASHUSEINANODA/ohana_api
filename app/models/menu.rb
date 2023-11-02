# frozen_string_literal: true

class Menu < ApplicationRecord
  extend Enumerize

  has_many :order_details
  belongs_to :flower_shop

  validates :name, :price, :flower_shop_id, :season, presence: true

  scope :cheapest, -> { order(price: :asc).first }
  scope :season_menu, lambda {
    spring_term = [3, 4, 5]
    summer_term = [6, 7, 8]
    automn_term = [9, 10, 11]
    winter_term = [12, 1, 2]

    case Time.zone.now.since(2.month).strftime('%m').to_i
    when *spring_term
      where(season: %i[spring all_season])
    when *summer_term
      where(season: %i[summer all_season])
    when *automn_term
      where(season: %i[automn all_season])
    when *winter_term
      where(season: %i[winter all_season])
    else
      all
    end
  }

  enumerize :season, in: {
    spring: 1,
    summer: 2,
    automn: 3,
    winter: 4,
    all_season: 0
  }, scope: true

  def name_with_price
    "#{name}(#{price}円)"
  end
end
