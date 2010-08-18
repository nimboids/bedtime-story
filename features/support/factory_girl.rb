require 'factory_girl'
Factory.definition_file_paths << "#{RAILS_ROOT}/factories"
Factory.find_definitions
require 'factory_girl/step_definitions' # needs to be after find_definitions