class UserSessionsController < InheritedResources::Base
  def create
    redirect_to admin_index_url
  end
end
