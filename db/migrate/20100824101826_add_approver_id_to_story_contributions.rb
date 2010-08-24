class AddApproverIdToStoryContributions < ActiveRecord::Migration
  def self.up
    add_column :story_contributions, :approver_id, :integer
  end

  def self.down
    remove_column :story_contributions, :approver_id
  end
end
