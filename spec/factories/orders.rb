# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    total_amount { 0 }
    ordered_at { nil }
    association :company, factory: 'company'
    association :flower_shop, factory: 'flower_shop'
  end
end
