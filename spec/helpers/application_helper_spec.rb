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
    it "should be 5pm on 1 October" do
      helper.finish_date.should == Time.local(2010, 'oct', 1, 17, 0, 0).to_datetime
    end
  end

  describe "opening times" do
    def freeze_time_to hours, minutes
      now = Time.now
      time = Time.local now.year, now.month, now.day, hours, minutes, 0
      Timecop.freeze time
    end

    context "before 8 a.m." do
      before { freeze_time_to 7,59 }
      it { helper.should_not be_open_for_contributions }
    end

    context "from 8 a.m." do
      before { freeze_time_to 8,00 }
      it { helper.should be_open_for_contributions }
    end

    context "before 11 p.m." do
      before { freeze_time_to 22,59 }
      it { helper.should be_open_for_contributions }
    end

    context "from 11 p.m." do
      before { freeze_time_to 23,00 }
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
    it "formats a datetime" do
      days, hours, minutes, seconds = 1, 2, 3, 4
      days_fraction = Rational((days * 86400) + (hours * 3600) + (minutes * 60) + seconds,86400)
      helper.formatted_countdown(days_fraction).should == %(<div class="countdown">
      <div class="number" id="countdown_days">#{days}</div>
      <div class="text">days</div>
      <div class="number" id="countdown_hours">#{hours}</div>
      <div class="text">hours</div>
      <div class="number" id="countdown_minutes">#{minutes}</div>
      <div class="text">minutes</div>
      <div class="number" id="countdown_seconds">#{seconds}</div>
      <div class="text">seconds</div>
    </div>)
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
