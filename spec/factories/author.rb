FactoryBot.define do
  factory :author do
    name {Faker::Name.name}

    after(:build) do |author|
      member = FactoryBot.create :member

      author.member_id = member.id
    end
  end
end
