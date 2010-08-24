class StoryContribution < ActiveRecord::Base
  belongs_to :approver, :class_name => "User"
  named_scope :approved, :conditions => "approver_id is not null"
  named_scope :awaiting_approval, :conditions => "approver_id is null and rejected != true"
end
