require File.expand_path "../spec_helper", __FILE__

describe "Routing" do
  it { should route(:post, "/contributions").to(:controller => "story_contributions", :action => "create") }
  it { should route(:post, "/contributions/approve").to(:controller => "story_contributions", :action => "approve") }
  it { should route(:get, "/").to(:controller => "home", :action => "show") }
  it { should route(:get, "/admin").to(:controller => "admin", :action => "index")}
  it { should route(:get, "/user_session/new").to(:controller => "user_sessions", :action => "new") }
  it { should route(:post, "/user_session").to(:controller => "user_sessions", :action => "create") }
  it { should route(:get, "/user_session/destroy").to(:controller => "user_sessions", :action => "destroy") }
  it { should route(:get, "/foo").to(:controller => "pages", :action => "show", :page => "foo") }
end
