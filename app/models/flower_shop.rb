# frozen_string_literal: true

class FlowerShop < ApplicationRecord
  has_many :company
  has_many :menus
  has_many :orders

  validates :name, :email, presence: true
end
