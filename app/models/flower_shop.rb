class FlowerShop < ApplicationRecord
    has_many :histories

    validates :name, :mail, presence: true
end
