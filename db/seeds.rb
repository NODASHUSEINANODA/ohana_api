# frozen_string_literal: true

require 'csv'

COMPANY_COUNT = 3
EMPLOYEE_COUNT = 100

FlowerShop.create!(
  name: 'Florist SAKURA',
  email: 'flower1@example.com',
  created_at: Time.current,
  updated_at: Time.current
)

csv_file_path = Rails.root.join('db', 'flowerlist.csv')
csv_data = CSV.read(csv_file_path)

csv_data.each do |row|
  Menu.create!(
    name: row[0],
    price: row[1],
    flower_shop_id: 1,
    season: row[2],
    created_at: Time.current,
    updated_at: Time.current
  )
end

# flower_shop_idはflower_shopのデータが作成されていることが前提、順番変えるとうまくいかない
COMPANY_COUNT.times do |n|
  Company.create!(
    email: "test#{n + 1}@example.com",
    password: 'password',
    name: "test#{n}株式会社",
    address: Gimei.unique.address,
    confirmed_at: Time.current,
    flower_shop_id: 1
  )
end

EMPLOYEE_COUNT.times do |n|
  birthday_year = Random.rand(1960..2000)
  birthday_month = (n % 12) + 1
  birthday_date = Random.rand(1..28)
  birthday = Date.parse("#{birthday_year}/#{birthday_month}/#{birthday_date}")
  address = Random.rand(1..2).even? ? Gimei.unique.address : ''

  Employee.create!(
    name: Gimei.unique.name.kanji,
    sex: Random.rand(1..2) == 2 ? '男性' : '女性',
    birthday: birthday,
    address: address,
    joined_at: birthday,
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
    email: "president#{n + 1}@#example.com",
    is_president: true
  )

  2.times do |m|
    Manager.create!(
      employee_id: Employee.where(company_id: company_id)[m + 2].id,
      email: "manager#{m + 2}@#example.com",
      is_president: false
    )
  end
end

# 次回の注文データを作成
Company.all.each(&:setup_next_order)
