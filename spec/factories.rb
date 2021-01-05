FactoryBot.define do
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
    piece_type { "pawn" }
    color { "white" }
    x { 1 }
    y { 2 }
    icon { "♙" }
    association :game
  end
end
