class Manager < ApplicationRecord
    belongs_to :employee
    has_many :histories
    has_many :temporaries

    validates :mail, :status, presence: true
end
