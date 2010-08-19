ActionController::Routing::Routes.draw do |map|
  map.root :controller => "pages", :action => "show", :page => "home"
  map.route "/:page", :controller => "pages", :action => "show"
end
