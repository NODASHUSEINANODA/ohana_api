# frozen_string_literal: true

FactoryBot.define do
  factory :flower_shop do
    name { 'florist SAKURA' }
    sequence(:email) { |n| "flowerlist#{n}@example.com" }
  end
end
