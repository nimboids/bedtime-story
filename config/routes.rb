ActionController::Routing::Routes.draw do |map|
  map.resources :story_contributions, :as => "contributions", :only => :create
  map.root :controller => "pages", :action => "show", :page => "home"
  map.route "/:page", :controller => "pages", :action => "show"
end
