require 'spec_helper'

describe CFCM::CF::Session do
	it "should request a Cloud Foundry token" do
		stub_request(:get, "http://api.vcap.local/info").
        	with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'0', 'User-Agent'=>'Ruby'}).
         	to_return(:status => 200, :body => "", :headers => {})

		session = CFCM::CF::Session.new("http://api.vcap.local", "someuser", "somepassword")

	end	
end
