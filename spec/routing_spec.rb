require File.expand_path "../spec_helper", __FILE__

describe "Routing" do
  it { should route(:post, "/contributions").to(:controller => "story_contributions", :action => "create")}
  it { should route(:get, "/").to(:controller => "pages", :action => "show", :page => "home")}
  it { should route(:get, "/foo").to(:controller => "pages", :action => "show", :page => "foo")}
end
