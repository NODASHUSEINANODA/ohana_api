# frozen_string_literal: true

class FlowerShop < ApplicationRecord
  has_many :histories
  has_many :company

  validates :name, :email, presence: true
end
