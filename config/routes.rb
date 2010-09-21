ActionController::Routing::Routes.draw do |map|
  map.resources :story_contributions, :as => "contributions", :only => [:create, :edit, :update], :collection => {:approve => :post, :approved => :get}
  map.resources :admin, :only => :index
  map.resource :user_session, :only => [:new, :create]
  map.logout "/user_session/destroy", :controller => :user_sessions, :action => :destroy
  map.rss "/rss", :controller => :story_contributions, :action => :index, :format => "rss"

  map.root :controller => "home", :action => "show"

  # catch-all pages route needs to be last
  map.page "/:page", :controller => "pages", :action => "show"

  if %w(development test).include? RAILS_ENV
    map.connect 'dummy/:action/:id', :controller => 'dummy'
  end
end
