class Relationship < ApplicationRecord
  belongs_to :follower, class_name: Member.name
  belongs_to :followed, class_name: Member.name
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
