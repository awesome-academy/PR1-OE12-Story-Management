FactoryBot.define do
  factory :member do
    name {Faker::Name.name}
    sequence(:email){Faker::Internet.email}
    password {"anhlam"}
    password_confirmation {"anhlam"}

    trait :invalid_email do
      email {Faker::Name.name}
    end

    trait :admin do
      admin {true}
    end

    trait :member do
      admin {false}
    end
  end
end
