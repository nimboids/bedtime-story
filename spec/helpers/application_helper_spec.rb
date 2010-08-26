require File.expand_path "../../spec_helper", __FILE__

describe ApplicationHelper do
  describe "generating a page title" do
    context "by default" do
      it "returns 'Byte Night Bedtime Story'" do
        helper.title.should == "Byte Night Bedtime Story"
      end
    end

    context "when the view specifies a title" do
      it "returns 'Byte Night Bedtime Story &ndash; <title>'" do
        helper.title "my page"
        helper.title.should == "Byte Night Bedtime Story &ndash; my page"
      end
    end
  end

  describe "generating the link to the home page" do
    before do
      @controller = mock
      helper.stub(:controller).and_return @controller
    end

    context "when on the home page" do
      before do
        @controller.stub(:controller_name).and_return "home"
      end

      it "generates a link with an id of 'home_active'" do
        helper.link_to_home.should == '<li><a href="/" id="home_active"><span>Home</span></a>'
      end
    end

    context "when not on the home page" do
      before do
        @controller.stub(:controller_name).and_return "foo"
      end

      it "generates a link with an id of 'home_inactive'" do
        helper.link_to_home.should == '<li><a href="/" id="home_inactive"><span>Home</span></a>'
      end
    end
  end

  describe "generating the link to a page" do
    before do
      @controller = mock :controller_name => "pages"
      helper.stub(:controller).and_return @controller
    end

    context "when on that page" do
      before do
        @controller.stub(:params).and_return({:page => "foo"})
      end

      it "generates a link with an id of '<page>_active'" do
        helper.link_to_page("foo", "Foo Bar").should == '<li><a href="/foo" id="foo_active"><span>Foo Bar</span></a>'
      end
    end

    context "when on another page" do
      before do
        @controller.stub(:params).and_return({:page => "bar"})
      end

      it "generates a link with an id of '<page>_inactive'" do
        helper.link_to_page("foo", "Foo Bar").should == '<li><a href="/foo" id="foo_inactive"><span>Foo Bar</span></a>'
      end
    end
  end
end
