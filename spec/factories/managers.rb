# frozen_string_literal: true

FactoryBot.define do
  factory :manager do
    email { 'test@example.com' }
    is_president { true }
  end
end
