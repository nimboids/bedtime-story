class UserSessionsController < InheritedResources::Base
  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      redirect_to admin_index_url
    else
      render :action => 'new'
    end
  end

  def destroy
    UserSession.find.destroy
    redirect_to root_url
  end
end
