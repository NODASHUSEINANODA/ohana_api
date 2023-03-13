class Company < ApplicationRecord
    has_one :employee

    validtes :name, :address, :email, presence: true
end
