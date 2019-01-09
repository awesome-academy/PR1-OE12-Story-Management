require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:member) {FactoryBot.create :member, :member}
  subject {member}

  let(:member_invalid) do
    {
      name: "",
      email: "",
      password: ""
    }
  end

  describe "GET #new" do
    it "assigns a blank member to the view" do
      get :new
      expect(assigns(:member)).to be_a_new(Member)
    end
  end

  context "GET #show" do
    it "render show member" do
      get :show, params: {id: member.id}
      expect(response).to render_template "show"
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create,
        params: {member: FactoryBot.attributes_for(:member)}}
      it "creates a new member" do
        expect(assigns(:member)).to be_a Member
        expect(Member.count).to eq(1)
      end
    end

    context "invalid params" do
      before {post :create, params: {member: member_invalid}}
      it{expect(response).to render_template :new}
    end
  end

  describe "PATCH #update" do
    context "update success" do
      it "update with name " do
        patch :update, params: {id: subject.id, member:{name: "tunglam"}}
        expect(response).to be_redirect
      end
    end

    context "update member" do
      it "update fail" do
        patch :update, params: {id: subject.id, member:{name: ""}}
        expect(response).to render_template()
      end
    end
  end
end
