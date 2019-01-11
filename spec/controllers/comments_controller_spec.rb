require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:member) {FactoryBot.create :member}
  let(:story) {FactoryBot.create :story}
  let(:comment) {FactoryBot.create :comment}
  before {log_in member}

  let(:comment_invalid) do
    {
      content: "",
      story_id: "",
      member_id: ""
    }
  end

  describe "GET #new" do
    it "assigns a blank comment to the view" do
      get :new, xhr: true
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create, xhr: true,
        params: {comment: FactoryBot.attributes_for(:comment, story_id: story.id, member_id: member.id)}}
      it "creates a new comment" do
        expect(assigns(:comment)).to be_a Comment
        expect(Comment.count).to eq(1)
      end
    end

    context "invalid params" do
      before {post :create, xhr: true, params: {comment: comment_invalid}}
      it{expect(response).to render_template()}
    end
  end

  describe "PATCH #update" do
    context "update success" do
      it "update with comment " do
        patch :update, xhr: true, params: {id: comment.id, comment:{content: "tunglamsdasđâsdasd"}}
        expect(flash[:success]).to match(I18n.t("comments.update.success"))
      end
    end

    context "update story" do
      it "update fail" do
        patch :update, xhr: true, params: {id: comment.id, comment:{content: ""}}
        expect(flash[:danger]).to match(I18n.t("comments.update.failed"))
      end
    end
  end

  describe "DELETE #destroy" do
    before {delete :destroy, xhr: true, params: {id: comment.id}}
    context "success" do
      it "test message" do
        expect(flash[:success]).to match(I18n.t("comments.destroy.success"))
      end
    end
  end

end
