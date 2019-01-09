class Follow < ApplicationRecord
  belongs_to :story
  belongs_to :member
  validates :story_id, presence: true
  validates :member_id, presence: true
end
