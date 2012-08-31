require "thor"
require "cfcm/monkey"

module CFCM
  module CLI
    class Command < Thor
      
      desc "soft USERNAME PASSWORD APP", "Removes/Adds instances via VMC APIs"
      method_option :target, :aliases => ["--target", "-t"], :type => :string, :desc => "Cloud Foundry API Target URL"
      method_option :min, :alias => ["--min"], :type => :numeric, :desc => "Minimum number of instances"
      method_option :max, :alias => ["--max"], :type => :numeric, :desc => "Maximum number of instances"
      method_option :probability, :aliases => ["--probability", "-p"], :type => :numeric, :desc => "[1-100] Probablity for the Chaos Monkey to Add/Remove an instance"
      def soft(username, password, app, target = "http://api.cloudfoundry.com", min = 1, max = 5, probability = 10)
        
        if options[:target]
          target = options[:target]
        end
        if options[:min]
          min = options[:min]
        end
        if options[:max]
          max = options[:max]
        end
        if options[:probability]
          if options[:probability] < 1 || options[:probability] > 100
            puts "Probability must be between 1 and 100"
            return
          else
            probability = options[:probability]
          end
        end

        require 'cfcm/cf'
        session = CFCM::CF::Session.new(target, username, password)
        if session.is_logged_in 
          if !session.app_exists(app)
            puts "Application not found"
            return
          end
        else
          puts "Could not log in"
          return
        end
        
        puts "Awakening the monkey on #{app} with a forecast of #{probability}% chance of chaos"
        monkey = CFCM::Monkey::SoftMonkey.new(session, app, probability, min, max)
        monkey.start
      end     
    end
  end
end