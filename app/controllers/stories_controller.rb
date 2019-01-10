class StoriesController < ApplicationController
  before_action :load_story, except: %i(index new create)
  before_action :logged_in_member, :admin_member, only: %i(create destroy)

  def show
    @comments = @story.comments.order_by(:desc).page(params[:page]).
      per Settings.paginate.per_page
    @chapters = @story.chapters.order_by(:asc).page(params[:page]).
      per Settings.paginate.per_page
  end

  def index
    @stories = Story.page(params[:page]).
      per Settings.paginate.per_page
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_member.stories.build story_params
    if @story.save
      flash[:success] = t ".post"
      redirect_to @story
    else
      render :new
    end
  end

  def update
    if @story.update story_params
      flash[:success] = t ".story_update"
      redirect_to @story
    else
      flash[:danger] = t ".story_update_fail"
      render :edit
    end
  end

  def edit; end

  def destroy
    if @story.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to stories_path
  end

  private

  def story_params
    params.require(:story).permit :name, :describe, :image,
      :author_id
  end

  def load_story
    @story = Story.find_by id: params[:id]
    return if @story
    redirect_to root_url
    flash[:danger] = t ".notfound"
  end

  def admin_member
    redirect_to(root_url) unless current_member.admin?
  end
end
