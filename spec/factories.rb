FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email { 'jake@mail.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end

  factory :car do
    name { Faker::Lorem.word }
    description { Faker::Lorem.word }
    price { 4.0 }
    model { Faker::Lorem.word }
    test_drive_fee { 5.0 }
    year { '2022-02-03' }
  end
end
