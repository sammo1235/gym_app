FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { "#{Faker::Name.name.split(/\s/).map(&:downcase).join('_')}#{rand(500..3000)}" }
    age { rand(15..90) }
    gender { rand(0..1) }
    bodyweight { rand(45..150) }
    password { Faker::Company.bs.gsub(/\s/, '') }
  end
end