class StoryContribution < ActiveRecord::Base
  belongs_to :approver, :class_name => :user
  named_scope :approved, :conditions => "approver_id is not null"
end
