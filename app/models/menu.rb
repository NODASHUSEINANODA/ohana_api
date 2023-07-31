# frozen_string_literal: true

class Menu < ApplicationRecord
  extend Enumerize

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

  def season_menu
    month = Time.now.month

    if [2, 3, 4].include?(month)
      Menu.where(season: :spring)
    elsif [5, 6, 7].include?(month)
      Menu.where(season: :summer)
    elsif [8, 9, 10].include?(month)
      Menu.where(season: :automn)
    elsif [11, 12, 1].include?(month)
      Menu.where(season: :winter)
    else
      Menu.all
    end
  end

  def name_with_price
    "#{name}(#{price}円)"
  end
end
