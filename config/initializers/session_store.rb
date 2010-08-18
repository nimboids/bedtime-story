# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bedtime_story_session',
  :secret      => '84ba9f58b2f6c381f6d0941879342b7c5f7b9ad15807ef7bce513eb4381648dc9224c010ee0620ad9ebbc23ac7bc3814ef1044a7abb3adbf076817aeea8df67b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
