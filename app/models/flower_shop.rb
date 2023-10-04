# frozen_string_literal: true

class FlowerShop < ApplicationRecord
  has_many :company
  has_many :menus
  has_many :orders

  validates :name, :email, presence: true

  def cheapest_menu_of_the_season
    menus.season_menu.cheapest
  end
end
