require 'spec_helper'

describe CFCM::CF::Session do
	it "should request a Cloud Foundry token" do
		VCR.use_cassette('cf_login') do
			session = CFCM::CF::Session.new("http://api.cloudfoundry.com", "someuser", "somepassword")
			session.is_logged_in?.should be_true
			session.client.token.should == "fake f@k3t0k3n"
			session.client.current_user.email.should == "someuser"
		end
	end	
end
