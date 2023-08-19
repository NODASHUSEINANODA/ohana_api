# frozen_string_literal: true

FactoryBot.define do
  factory :order_detail do
    deliver_to { 0 }
    discarded_at { nil }
    association :order, factory: 'order'
    association :employee, factory: 'employee'
    association :menu, factory: 'menu'
  end
end
