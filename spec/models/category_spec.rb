require "rails_helper"

RSpec.describe Category, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:category_stories) }
    it { is_expected.to have_many(:stories) }
  end
end
