require File.expand_path "../../spec_helper", __FILE__

describe StoryContribution do
  it { should have_db_column(:text).of_type(:string) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }
  it { should have_db_column(:approver_id).of_type(:integer) }

  it { should belong_to(:approver) }

  describe "approved named scope" do
    it "only includes records with approvers" do
      contrib_1 = Factory :story_contribution
      contrib_2 = Factory :story_contribution, :approver_id => 1
      StoryContribution.approved.should == [contrib_2]
    end
  end
end
