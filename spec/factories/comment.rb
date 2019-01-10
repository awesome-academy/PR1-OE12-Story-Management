FactoryBot.define do
  factory :comment do
    content {"comment 1"}

    after(:build) do |comment|
      member = FactoryBot.create :member
      story = FactoryBot.create :story

      comment.member_id = member.id
      comment.story_id = story.id
    end
  end
end
