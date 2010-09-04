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
  it { should ensure_length_of(:name).is_at_most(100) }
  it { should_not allow_mass_assignment_of(:approver) }
  it { should_not allow_mass_assignment_of(:approver_id) }
  it { should_not allow_mass_assignment_of(:rejected) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }

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

  describe "approving" do
    before do
      @approver = Factory :user
      StoryContribution.destroy_all
      @contrib_1 = Factory :story_contribution
      @contrib_2 = Factory :story_contribution, :text => "original text"
      @contrib_3 = Factory :story_contribution
    end

    def do_approve
      StoryContribution.approve @contrib_2.id, @approver, "edited text"
    end

    it "updates the story text" do
      do_approve
      @contrib_2.reload.text.should == "edited text"
    end

    it "marks the contribution as approved by the correct user" do
      do_approve
      @contrib_2.reload.approver.should == @approver
    end

    it "marks all other contribution awaiting approval as rejected" do
      do_approve
      StoryContribution.awaiting_approval.should be_empty
    end
  end
end
