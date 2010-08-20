require File.expand_path "../../spec_helper", __FILE__

describe StoryContribution do
  it { should have_db_column(:text).of_type(:string)}
  it { should have_db_column(:created_at).of_type(:datetime)}
  it { should have_db_column(:updated_at).of_type(:datetime)}
end
