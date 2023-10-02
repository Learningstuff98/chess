FactoryBot.define do
  factory :event_message do
    
  end

  factory :comment do
    
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

  factory :piece do
    piece_type { "queen" }
    color { "black" }
    x { 5 }
    y { 5 }
    destination_x { 4 }
    destination_y { 4 }
    association :game
  end
end
