require_relative '../lib/cfcm'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
	config.before(:all) do
		VCR.use_cassette('cf_login') do
			@client = CFCM::CF::Session.new("http://api.cloudfoundry.com", "someuser", "somepassword")
		end
	end
end