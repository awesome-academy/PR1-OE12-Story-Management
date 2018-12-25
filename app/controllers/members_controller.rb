class MembersController < ApplicationController
  before_action :load_member, only: %i(show edit)
  before_action :logged_in_member, only: %i(edit update index)
  before_action :correct_member, only: %i(edit update)

  def index
    @members = Member.by_attributes.order(:name).page(params[:page]).
      per Settings.paginate.per_page
  end

  def show; end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new member_params
    if @member.save
      log_in @member
      flash[:success] = t ".welcome"
      redirect_to @member
    else
      render :new
    end
  end

  def update
    if @member.update member_params
      flash[:success] = t ".profile_update"
      redirect_to @member
    else
      render :edit
    end
  end

  def edit; end

  private

  def member_params
    params.require(:member).permit :name, :email, :password,
      :password_confirmation
  end

  def load_member
    @member = Member.find_by id: params[:id]
    return if @member
    redirect_to root_url
    flash[:danger] = t ".notfound"
  end

  def logged_in_member
    return if logged_in?
    store_location
    flash[:danger] = t ".please_login"
    redirect_to root_url
  end

  def correct_member
    @member = Member.find_by id: params[:id]
    redirect_to(root_url) unless current_member? @member
  end
end
