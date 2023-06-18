# frozen_string_literal: true

3.times do |n|
  FlowerShop.create!(
    name: Gimei.name.last.kanji.concat('花屋'),
    email: "flower#{n + 1}@example.com",
    created_at: Time.current,
    updated_at: Time.current
  )
end

# flower_shop_idはflower_shopのデータが作成されていることが前提、順番変えるとうまくいかない
3.times do |n|
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

50.times do |_n|
  s1 = Date.parse('2000/07/1')
  s2 = Date.parse('2000/07/30')
  s = Random.rand(s1..s2)
  Employee.create!(
    name: Gimei.unique.name.kanji,
    sex: Random.rand(1..2) == 2 ? '男性' : '女性',
    birthday: s,
    address: Gimei.unique.address,
    joined_at: s,
    phone_number: '09011112222',
    message: Random.rand(1..2) == 2 ? '情熱的' : '落ち着いている',
    company_id: Random.rand(1..3)
  )
end
