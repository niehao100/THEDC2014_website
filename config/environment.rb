# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Thedc2013::Application.initialize!

Time::DATE_FORMATS[:short_form] = '%m-%d %H:%M'
