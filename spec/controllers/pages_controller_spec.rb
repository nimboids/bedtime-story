require File.expand_path "../../spec_helper", __FILE__

describe PagesController do
  describe "show" do
    it "renders the template given in 'page'" do
      get :show, :page => "foo"
      response.should render_template("foo")
    end
  end
end
