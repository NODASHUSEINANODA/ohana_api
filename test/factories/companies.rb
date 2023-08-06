# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'test株式会社' }
    address { '沖縄県那覇市' }
    sequence(:email) { |n| "company#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.zone.now }
    association :flower_shop, factory: 'flower_shop'
  end
end
