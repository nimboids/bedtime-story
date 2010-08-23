class AdminController < ApplicationController
  before_filter :authenticate

  def index
  end

  private

  def authenticate
    redirect_to new_user_session_url unless current_user
  end
end
