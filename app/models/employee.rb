class Employee < ApplicationRecord
    belongs_to :company
    has_one :manager
    has_many :histories, dependent: :destroy
    has_many :temporaries, dependent: :destroy

    validates :name, :sex, :birthday, :address, :work_year, :phone_number, :message, :company_id, presence: true
end
