# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :finish_date

  helper_method :current_user

  FINISH_DATE = Time.local(2010, 'oct', 1, 17, 0, 0).to_datetime

  def finish_date
    @finish_date = FINISH_DATE
  end

  def current_user
    @current_user = current_user_session.try :record
  end

  private

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def authenticate
    redirect_to new_user_session_url unless current_user
  end
end
