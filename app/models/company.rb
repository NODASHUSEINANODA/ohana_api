class Company < ApplicationRecord
    has_many :employee

    validtes :name, :address, :email, presence: true
end
