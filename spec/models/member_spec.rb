require "rails_helper"

RSpec.describe Member, :type => :model do
  let(:member) {FactoryBot.create :member}
  subject {member}

  context "when name is not valid" do
    before {subject.name = ""}
    it {is_expected.not_to be_valid}
  end

  context "when email is invalid" do
    before { subject.email = "anhgmail.com" }
    it { expect(subject).not_to match /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  end

  context "when email is not valid" do
    before {subject.email = ""}
    it {is_expected.not_to be_valid}
  end

  describe "db schema" do
    context "columns" do
      it { is_expected.to have_db_column(:email).of_type(:string) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:password).of_type(:string) }
      it { is_expected.to have_db_column(:admin).of_type(:boolean) }
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(
      Settings.Member.name.maximum) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(
      Settings.Member.email.maximum) }
    it { is_expected.to validate_length_of(:password) .is_at_least(
      Settings.Member.password.minimum) }
  end

  describe "associations" do
    it { is_expected.to have_many(:stories).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:authors).dependent(:destroy) }
    it { is_expected.to have_many(:chapters).dependent(:destroy) }
    it { is_expected.to have_many :following }
    it { is_expected.to have_many :followers }
    it { is_expected.to have_many :follows }
  end

end
