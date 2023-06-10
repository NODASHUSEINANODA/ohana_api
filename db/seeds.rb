3.times do |n|
  Company.create!(
    email: "test#{n + 1}@example.com",
    password: 'password',
    name: "test#{n}株式会社",
    address: Gimei.unique.address,
    confirmed_at: Time.current
  )
end

50.times do |n|
  s1 = Date.parse('2000/06/1')
  s2 = Date.parse('2000/06/30')
  s = Random.rand(s1..s2)
  Employee.create!(
    name: Gimei.unique.name.kanji,
    sex: Random.rand(1..2) == 2 ? '男' : '女',
    birthday: s,
    address: Gimei.unique.address,
    joined_at: s,
    phone_number: '09011112222',
    message: Random.rand(1..2) == 2 ? '情熱的' : '落ち着いている',
    company_id: Random.rand(1..3)
  )
end
