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
end
