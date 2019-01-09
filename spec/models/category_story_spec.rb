require "rails_helper"

RSpec.describe CategoryStory, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:story) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:category_id) }
    it { is_expected.to validate_presence_of(:story_id) }
  end

  describe "db schema" do
    context "columns" do
      it { is_expected.to have_db_column(:category_id).of_type(:integer) }
      it { is_expected.to have_db_column(:story_id).of_type(:integer) }
    end
  end
end
