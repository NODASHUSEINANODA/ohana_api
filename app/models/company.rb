class Company < ApplicationRecord
    has_many :employee

    validtes :name, :address, :email, presence: true
    
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable, :confirmable # ← confirmableを追加する
    include DeviseTokenAuth::Concerns::User
end
