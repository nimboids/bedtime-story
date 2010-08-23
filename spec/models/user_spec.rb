require 'spec_helper'

describe User do
  it { should have_db_column(:login).of_type(:string)}
  it { should have_db_column(:email).of_type(:string)}
  it { should have_db_column(:crypted_password).of_type(:string)}
  it { should have_db_column(:password_salt).of_type(:string)}
  it { should have_db_column(:persistence_token).of_type(:string)}
  it { should have_db_column(:created_at).of_type(:datetime)}
  it { should have_db_column(:updated_at).of_type(:datetime)}

  it "should act as authentic" do
    User.included_modules.should include(Authlogic::ActsAsAuthentic::Password::Methods)
  end
end
