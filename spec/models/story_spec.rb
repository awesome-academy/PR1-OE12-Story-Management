require "rails_helper"

RSpec.describe Story, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:member) }
    it { is_expected.to belong_to(:author) }
    it { is_expected.to have_many(:category_stories) }
    it { is_expected.to have_many(:categories) }
    it { is_expected.to have_many(:follows) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:chapters).dependent(:destroy) }

  end

  describe "db schema" do
    context "columns" do
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:describe).of_type(:text) }
      it { is_expected.to have_db_column(:image).of_type(:string) }
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(
      Settings.Story.name.maximum) }
    it { is_expected.to validate_presence_of(:describe) }
    it { is_expected.to validate_length_of(:describe) .is_at_least(
      Settings.Story.describe.minimum) }
  end
end
