FactoryBot.define do
  factory :chapter do
    name {Faker::Name.name}
    content {"noi dung cua chap 1"}
    story_id { 1 }
    member_id { 1 }
  end
end
