class History < ApplicationRecord
    belongs_to :employee
    belongs_to :manager
    belongs_to :flower_shop
end
