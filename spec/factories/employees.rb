# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    name { 'test' }
    address { '沖縄県那覇市' }
    sex { '男性' }
    message { '落ち着いてる' }
    phone_number { '09011112222' }
    joined_at { Time.zone.now }
    birthday { Time.zone.now }
    association :company, factory: 'company'

    trait :with_manager do
      after(:create) do |employee|
        FactoryBot.create(:manager, employee_id: employee.id)
      end
    end

    trait :invalid do
      name { '' }
    end
  end
end
