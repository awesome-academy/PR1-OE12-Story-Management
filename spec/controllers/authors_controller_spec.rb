require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:member) {FactoryBot.create :member, admin: true}
  let(:author) {FactoryBot.create :author}
  before {log_in member}

  let(:author_invalid) do
    {
      name: "",
      member_id: ""
    }
  end

  describe "GET #new" do
    it "assigns a blank author to the view" do
      get :new
      expect(assigns(:author)).to be_a_new(Author)
    end
  end

  context "GET #show" do
    it "render show author" do
      get :show, params: {id: author.id}
      expect(response).to render_template "show"
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create,
        params: {author: FactoryBot.attributes_for(:author, member_id: member.id)}}
      it "creates a new author" do
        expect(Author.count).to eq(1)
      end
    end

    context "invalid params" do
      before {post :create, params: {author: author_invalid}}
      it{expect(response).to render_template()}
    end
  end

  describe "PATCH #update" do
    context "update success" do
      it "update with name " do
        patch :update, params: {id: author.id, author:{name: "tunglamsdasđâsdasd"}}
        expect(flash[:success]).to match(I18n.t("authors.update.author_update"))
        expect(response).to be_redirect
      end
    end

    context "update story" do
      it "update fail" do
        patch :update, params: {id: author.id, author:{name: ""}}
        expect(flash[:danger]).to match(I18n.t("authors.update.author_update_fail"))
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before {delete :destroy, params: {id: author.id}}
    context "success" do
      it "test message" do
        expect(flash[:success]).to match(I18n.t("authors.destroy.success"))
      end
    end
  end
end
