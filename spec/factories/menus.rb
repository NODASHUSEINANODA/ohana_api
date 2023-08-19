# frozen_string_literal: true

FactoryBot.define do
  factory :menu do
    sequence(:name) { |n| "menu_#{n}" }
    price { 3000 }
    season { 1 } # 1:春, 2:夏, 3:秋, 4:冬
    association :flower_shop, factory: 'flower_shop'
  end
end
