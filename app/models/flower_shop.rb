class FlowerShop < ApplicationRecord
    has_many :histories
    belongs_to :company

    validates :name, :mail, presence: true
end
