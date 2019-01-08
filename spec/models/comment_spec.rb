require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:member) }
    it { is_expected.to belong_to(:story) }
  end

  describe "db schema" do
    context "columns" do
      it { is_expected.to have_db_column(:content).of_type(:text) }
      it { is_expected.to have_db_column(:story_id).of_type(:integer) }
      it { is_expected.to have_db_column(:member_id).of_type(:integer) }
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(
      Settings.Comment.content) }
  end
end
