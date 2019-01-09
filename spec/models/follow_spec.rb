require "rails_helper"

RSpec.describe Follow, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:member) }
    it { is_expected.to belong_to(:story) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:member_id) }
    it { is_expected.to validate_presence_of(:story_id) }
  end

  describe "db schema" do
    context "columns" do
      it { is_expected.to have_db_column(:member_id).of_type(:integer) }
      it { is_expected.to have_db_column(:story_id).of_type(:integer) }
    end
  end
end
