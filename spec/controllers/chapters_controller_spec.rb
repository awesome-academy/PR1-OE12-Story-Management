require 'rails_helper'

RSpec.describe ChaptersController, type: :controller do
  let(:member) {FactoryBot.create :member, admin: true}
  let(:story) {FactoryBot.create :story}
  let(:chapter) {FactoryBot.create :chapter}
  before {log_in member}

  let(:chapter_invalid) do
    {
      name: "",
      story_id: "",
      member_id: ""
    }
  end

  describe "GET #new" do
    it "assigns a blank chapter to the view" do
      get :new, xhr: true
      expect(assigns(:chapter)).to be_a_new(Chapter)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create, xhr: true,
        params: {chapter: FactoryBot.attributes_for(:chapter, story_id: story.id, member_id: member.id)}}
      it "creates a new chapter" do
        expect(assigns(:chapter)).to be_a Chapter
        expect(Chapter.count).to eq(1)
      end
    end

    context "invalid params" do
      before {post :create, xhr: true, params: {chapter: chapter_invalid}}
      it{expect(response).to render_template()}
    end
  end

  describe "DELETE #destroy" do
    before {delete :destroy, xhr: true, params: {id: chapter.id}}
    context "success" do
      it "test message" do
        expect(flash[:success]).to match(I18n.t("chapters.destroy.success"))
      end
    end
  end

end
