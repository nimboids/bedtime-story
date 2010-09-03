require File.expand_path "../../spec_helper", __FILE__

describe StoryContribution do
  it { should have_db_column(:text).of_type(:string) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }
  it { should have_db_column(:approver_id).of_type(:integer) }
  it { should have_db_column(:rejected).of_type(:boolean) }
  it { should have_db_column(:name).of_type(:text) }
  it { should validate_presence_of(:text) }
  it { should ensure_length_of(:text).is_at_most(140) }

  it { should belong_to(:approver) }

  it "defaults 'rejected' to false" do
    Factory(:story_contribution, :rejected => nil).rejected.should be_false
  end

  describe "'approved' named scope" do
    it "only includes records with approvers" do
      contrib_1 = Factory :story_contribution
      contrib_2 = Factory :story_contribution, :approver_id => 1
      StoryContribution.approved.should == [contrib_2]
    end
  end

  describe "'awaiting_approval' named scope" do
    it "only includes non-rejected records without approvers" do
      contrib_1 = Factory :story_contribution, :rejected => true
      contrib_2 = Factory :story_contribution, :approver_id => 1
      contrib_3 = Factory :story_contribution
      contrib_4 = Factory :story_contribution, :rejected => false
      StoryContribution.awaiting_approval.should == [contrib_3, contrib_4]
    end
  end
end
