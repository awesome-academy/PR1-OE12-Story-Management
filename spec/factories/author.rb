FactoryBot.define do
  factory :author do
    name {Faker::Name.name}
    member_id { 1 }
  end
end
