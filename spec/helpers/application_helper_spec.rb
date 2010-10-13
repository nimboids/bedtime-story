require File.expand_path "../../spec_helper", __FILE__
require "timecop"

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

  describe "finish date" do
    it "is 5pm BST on 13 October" do
      helper.finish_date.should == Time.gm(2010, 'oct', 13, 16, 0, 0).to_datetime
    end
  end

  describe "opening times" do
    def freeze_time_to hours, minutes
      now = Time.now
      time = Time.gm now.year, now.month, now.day, hours, minutes, 0
      Timecop.freeze time
    end

    context "before 0700 GMT" do
      before { freeze_time_to 6,59 }
      it { helper.should_not be_open_for_contributions }
    end

    context "from 0700 GMT" do
      before { freeze_time_to 7,00 }
      it { helper.should be_open_for_contributions }
    end

    context "before 2200 GMT" do
      before { freeze_time_to 21,59 }
      it { helper.should be_open_for_contributions }
    end

    context "from 2200 GMT" do
      before { freeze_time_to 22,00 }
      it { helper.should_not be_open_for_contributions }
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
        helper.link_to_home.should == '<li><a href="/" class="star" id="home_active"><span>Home</span></a></li>'
      end
    end

    context "when not on the home page" do
      before do
        @controller.stub(:controller_name).and_return "foo"
      end

      it "generates a link with an id of 'home_inactive'" do
        helper.link_to_home.should == '<li><a href="/" class="star" id="home_inactive"><span>Home</span></a></li>'
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
        helper.link_to_page("foo", "Foo Bar").should == '<li><a href="/foo" class="star" id="foo_active"><span>Foo Bar</span></a></li>'
      end
    end

    context "when on another page" do
      before do
        @controller.stub(:params).and_return({:page => "bar"})
      end

      it "generates a link with an id of '<page>_inactive'" do
        helper.link_to_page("foo", "Foo Bar").should == '<li><a href="/foo" class="star" id="foo_inactive"><span>Foo Bar</span></a></li>'
      end
    end
  end

  describe "generating a countdown" do
    context "before the closing time" do
      it "formats a datetime" do
        days, hours, minutes, seconds = 1, 2, 3, 4
        days_fraction = Rational((days * 86400) + (hours * 3600) + (minutes * 60) + seconds,86400)
        helper.formatted_countdown(days_fraction).should have_tag("div.countdown") do
          with_tag "div.text", :text => "days"
          with_tag "div.number#countdown_days", :text => days
          with_tag "div.text", :text => "hours"
          with_tag "div.number#countdown_hours", :text => hours
          with_tag "div.text", :text => "minutes"
          with_tag "div.number#countdown_minutes", :text => minutes
          with_tag "div.text", :text => "seconds"
          with_tag "div.number#countdown_seconds", :text => seconds
        end
      end
    end
  end

  describe "preloading images" do
    it "renders images for *-active.png, with class 'hidden'" do
      html = helper.preload_images
      Dir["#{RAILS_ROOT}/public/images/*-active.png"].each do |file|
        html.should have_tag("img.hidden[src='/images/#{File.basename file}'][alt=""][class='hidden']")
      end
    end
  end
end
