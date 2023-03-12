3.times do |n|
    Company.create!(
        name: Gimei.unique.last.to_s.concat("株式会社"),
        address: Gimei.unique.address,
        email: Faker::Internet.unique.email,
    )
end

3.times do |n|
    FlowerShop.create!(
        name: Gimei.unique.last.to_s.concat("花屋"),
        email: Faker::Internet.unique.email,
    )
end

def generateSex()
    num = Random.rand(1..11)
    if num.even?
        return "男性"
    else
        return "女性"
    end
end

def generateText()
    if Random.rand(0..2) == 1
        return "赤が好き"
    else
        return "白が好き"
    end
end

50.times do |n|
    s1 = Date.parse("1970/01/1")
    s2 = Date.parse("2000/12/31")
    s = Random.rand(s1 .. s2)
    Employee.create!(
        name: Gimei.unique.name.kanji,
        sex: generateSex,
        birthday: s,
        address: Gimei.unique.address,
        work_year: Random.rand(1..30),
        phone_number: "09011112222",
        message: generateText,
        company_id: Random.rand(1..3),
    )
end

3.times do |n|
    Manager.create!(
        employee_id: Random.rand(1..50),
        email: Faker::Internet.unique.email,
        status: Random.rand(0..2) == 1 ? true : false,
    )
end
