class StaticPagesController < ApplicationController
  def home
    @stories = Story.all.page(params[:page]).per Settings.paginate.per_page
    if params[:search]
      @seach_term = params[:search]
      @stories = @stories.search_by(@seach_term)
    end
    @news = Story.limit(Settings.limit).order_by(:desc)
  end

  def help; end

  def about; end

  def contact; end

  def like_unlike
    story = Story.find_by id: params[:id]
    @follow = story.follow_unfolow(current_member.id) if story
    respond_to do |format|
      format.js
    end
  end
end
