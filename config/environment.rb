# Load the rails application
require File.expand_path('../application', __FILE__)

# Compile coffee script in bare mode
#Tilt::CoffeeScriptTemplate.default_bare = true

# Initialize the rails application
TrackerPoker::Application.initialize!
