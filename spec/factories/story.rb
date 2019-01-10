FactoryBot.define do
  factory :story do
    name {"Dế mèn phiêu lưu kí"}
    describe {"câu truyện kể về một chú dế phiêu lưu"}

    after(:build) do |story|
      member = FactoryBot.create :member
      author = FactoryBot.create :author

      story.member_id = member.id
      story.author_id = author.id
    end
  end
end
