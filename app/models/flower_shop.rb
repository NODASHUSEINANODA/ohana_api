class FlowerShop < ApplicationRecord
    has_many :histories
    belongs_to :company

    validates :name, :email, presence: true
end
