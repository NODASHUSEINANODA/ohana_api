class FlowerShop < ApplicationRecord
    has_many :histories
    has_many :company
    has_many :menus

    validates :name, :email, presence: true
end
