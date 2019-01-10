FactoryBot.define do
  factory :chapter do
    name {Faker::Name.name}
    content {"noi dung cua chap 1"}

    after(:build) do |chapter|
      member = FactoryBot.create :member
      story = FactoryBot.create :story

      chapter.member_id = member.id
      chapter.story_id = story.id
    end
  end
end
