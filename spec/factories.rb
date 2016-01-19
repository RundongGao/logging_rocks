require 'date'

FactoryGirl.define do
  factory :climber do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end

  trait :public do
    public true
  end

  trait :private do
    public false
  end

  factory :training do
    date Date.today.to_s
    climber_id 1
  end
end

