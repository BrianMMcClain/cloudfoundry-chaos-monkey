require "thor"

module CFCM
  module CLI
    class Command < Thor
     
      desc "soft USERNAME PASSWORD APP", "Removes/Adds instances via VMC APIs"
      method_option :target, :alias => ["--target"], :type => :string, :desc => "Cloud Foundry API Target URL"
      method_option :min, :alias => ["--min"], :type => :numeric, :desc => "Minimum number of instances"
      method_option :max, :alias => ["--max"], :type => :numeric, :desc => "Maximum number of instances"
      def soft(username, password, app, target = "http://api.cloudfoundry.com", min = 1, max = 5)
        
        if options[:target]
          target = options[:target]
        end
        if options[:min]
          min = options[:min]
        end
        if options[:max]
          min = options[:max]
        end
        
        require 'cfcm/cf'
        session = CFCM::CF::Session.new(target, username, password)
      end     
    end
  end
end