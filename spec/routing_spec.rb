require File.expand_path "../spec_helper", __FILE__

describe "Routing" do
  it { should route(:post, "/contributions").to(:controller => "story_contributions", :action => "create") }
  it { should route(:get, "/contributions/1/edit").to(:controller => "story_contributions", :action => "edit", :id => "1") }
  it { should route(:put, "/contributions/1").to(:controller => "story_contributions", :action => "update", :id => "1") }
  it { should route(:post, "/contributions/approve").to(:controller => "story_contributions", :action => "approve") }
  it { should route(:get, "/contributions/approved").to(:controller => "story_contributions", :action => "approved") }
  it { should route(:get, "/").to(:controller => "home", :action => "show") }
  it { should route(:get, "/admin").to(:controller => "admin", :action => "index")}
  it { should route(:get, "/user_session/new").to(:controller => "user_sessions", :action => "new") }
  it { should route(:post, "/user_session").to(:controller => "user_sessions", :action => "create") }
  it { should route(:get, "/user_session/destroy").to(:controller => "user_sessions", :action => "destroy") }
  it { should route(:get, "/foo").to(:controller => "pages", :action => "show", :page => "foo") }
  it { should route(:get, "/rss").to(:controller => "story_contributions", :action => "index", :format => "rss") }
  it { should route(:get, "/contributions/export.csv").to(:controller => "story_contributions", :action => "export", :format => :csv) }
end
