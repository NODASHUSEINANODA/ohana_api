# frozen_string_literal: true

COMPANY_COUNT = 3
FLOWER_SHOP_COUNT = 3
EMPLOYEE_COUNT = 50

FLOWER_SHOP_COUNT.times do |n|
  FlowerShop.create!(
    name: Gimei.name.last.kanji.concat('花屋'),
    email: "flower#{n + 1}@example.com",
    created_at: Time.current,
    updated_at: Time.current
  )
end

FLOWER_SHOP_COUNT.times do |n|
  menus = [
    { price: 3000, name: 'ローズブーケ' },
    { price: 5000, name: 'ミックスカラーブーケ' },
    { price: 8000, name: 'ライラックブーケ' }
  ]

  menus.each do |menu|
    Menu.create!(
      name: menu[:name],
      price: menu[:price],
      flower_shop_id: n + 1,
      created_at: Time.current,
      updated_at: Time.current
    )
  end
end

# flower_shop_idはflower_shopのデータが作成されていることが前提、順番変えるとうまくいかない
COMPANY_COUNT.times do |n|
  flower_shop_id_first = FlowerShop.first.id
  flower_shop_id_last = FlowerShop.last.id

  Company.create!(
    email: "test#{n + 1}@example.com",
    password: 'password',
    name: "test#{n}株式会社",
    address: Gimei.unique.address,
    confirmed_at: Time.current,
    flower_shop_id: Random.rand(flower_shop_id_first..flower_shop_id_last)
  )
end

EMPLOYEE_COUNT.times do |_n|
  s1 = Date.parse('2000/07/1')
  s2 = Date.parse('2000/07/30')
  s = Random.rand(s1..s2)
  address = Random.rand(1..2).even? ? Gimei.unique.address : nil

  Employee.create!(
    name: Gimei.unique.name.kanji,
    sex: Random.rand(1..2) == 2 ? '男性' : '女性',
    birthday: s,
    address: address,
    joined_at: s,
    phone_number: address ? '09011112222' : nil,
    message: Random.rand(1..2) == 2 ? '情熱的' : '落ち着いている',
    company_id: Random.rand(1..3)
  )
end

# 1つの会社に社長を1人、管理者を2人作成
COMPANY_COUNT.times do |n|
  company_id = Company.find(n + 1).id

  Manager.create!(
    employee_id: Employee.where(company_id: company_id).first.id,
    company_id: company_id,
    email: "president#{n + 1}@#example.com",
    is_president: true
  )

  2.times do |m|
    Manager.create!(
      employee_id: Employee.where(company_id: company_id)[m + 2].id,
      company_id: company_id,
      email: "manager#{m + 2}@#example.com",
      is_president: false
    )
  end
end

# 次回の注文データを作成
Company.all.each(&:setup_next_order)
