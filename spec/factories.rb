FactoryBot.define do
  factory :piece do
    
  end

  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    sequence :username do |n|
      "dummy_user_name#{n}"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :game do
    host_as_white { true }
    association :user
  end
end
