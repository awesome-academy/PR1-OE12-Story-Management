class SessionsController < ApplicationController
  def new; end

  def create
    member = Member.find_by email: params[:session][:email].downcase
    if member&.authenticate params[:session][:password]
      log_in member
      params[:session][:remember_me] == "1" ? remember(member) : forget(member)
      redirect_back_or member
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
