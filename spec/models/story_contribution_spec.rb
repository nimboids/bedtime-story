require File.expand_path "../../spec_helper", __FILE__

describe StoryContribution do
  it { should have_db_column(:text).of_type(:string) }
  it { should have_db_column(:original_text).of_type(:string) }
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }
  it { should have_db_column(:approver_id).of_type(:integer) }
  it { should have_db_column(:rejected).of_type(:boolean) }
  it { should validate_presence_of(:text) }
  it { should ensure_length_of(:text).is_at_most(140) }
  it { should ensure_length_of(:name).is_at_most(100) }
  it { should_not allow_mass_assignment_of(:original_text) }
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

  context "on creation" do
    it "saves the original text" do
      contrib = StoryContribution.create :text => "some text"
      contrib.reload.original_text.should == "some text"
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

    context "when the text is updated successfully" do
      it "marks the contribution as approved by the correct user" do
        do_approve
        @contrib_2.reload.approver.should == @approver
      end

      it "marks all other contribution awaiting approval as rejected" do
        do_approve
        StoryContribution.awaiting_approval.should be_empty
      end

      it "returns true" do
        do_approve.should be_true
      end
    end

    context "when updated text is too long" do
      def do_approve
        StoryContribution.approve @contrib_2.id, @approver, "X" * 141
      end

      it "does not mark the contribution as approved" do
        lambda {do_approve}
        @contrib_2.reload.approver.should be_nil
      end

      it "does not marks any contributions as rejected" do
        lambda {do_approve}
        StoryContribution.awaiting_approval.should have(3).elements
      end

      it "raises an error" do
        lambda {do_approve}.should raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
