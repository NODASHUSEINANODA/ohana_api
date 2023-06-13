class Manager < ApplicationRecord
    belongs_to :employee
    has_many :histories
    has_many :temporaries

    validates :email, presence: true
    validates :status, inclusion: [true, false]
end
