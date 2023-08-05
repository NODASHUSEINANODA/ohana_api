# frozen_string_literal: true

class Menu < ApplicationRecord
  extend Enumerize

  has_many :order_details
  belongs_to :flower_shop

  validates :name, :price, :flower_shop_id, :season, presence: true

  scope :cheapest, -> { order(price: :asc).first }
  scope :season_menu, -> { season_menus }

  enumerize :season, in: {
    spring: 1,
    summer: 2,
    automn: 3,
    winter: 4
  }, scope: true

  def self.season_menus
    month = Time.now.month
    spring_term = [2, 3, 4]
    summer_term = [5, 6, 7]
    automn_term = [8, 9, 10]
    winter_term = [11, 12, 1]

    case month
    when *spring_term
      Menu.where(season: :spring)
    when *summer_term
      Menu.where(season: :summer)
    when *automn_term
      Menu.where(season: :automn)
    when *winter_term
      Menu.where(season: :winter)
    else
      Menu.all
    end
  end

  def name_with_price
    "#{name}(#{price}円)"
  end
end
