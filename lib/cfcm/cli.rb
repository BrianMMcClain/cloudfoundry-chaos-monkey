require "thor"
require "cfcm/monkey"

module CFCM
  module CLI
    class Command < Thor
      
      desc "version", "Get version info"
      def version
        require 'cfcm/version'
        puts CFCM::VERSION
      end
      
      desc "soft USERNAME PASSWORD APP", "Removes/Adds instances via VMC APIs"
      method_option :target, :aliases => ["--target", "-t"], :type => :string, :desc => "Cloud Foundry API Target URL (Default: http://api.cloudfoundry.com)"
      method_option :min, :alias => ["--min"], :type => :numeric, :desc => "Minimum number of instances (Default: 1)"
      method_option :max, :alias => ["--max"], :type => :numeric, :desc => "Maximum number of instances (Default: 5)"
      method_option :probability, :aliases => ["--probability", "-p"], :type => :numeric, :desc => "[1-100] Probablity for the Chaos Monkey to add/remove an instance (Default: 10)"
      method_option :frequency, :aliases => ["--frequency", "-f"], :type => :numeric, :desc => "Number of seconds between attempts to add/remove an instance (Default: 10)"
      def soft(username, password, app, target = "http://api.cloudfoundry.com", min = 1, max = 5, probability = 10, frequency = 10)
        
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
        if options[:frequency]
          frequency = options[:frequency]
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
        
        puts "Awakening the monkey on #{app} with a #{probability}% chance of chaos every #{frequency} second#{frequency > 1? "s" : ""}"
        monkey = CFCM::Monkey::SoftMonkey.new(session, app, probability, min, max, frequency)
        monkey.start
      end     
      
      
      desc "hard", "Removes/Adds DEAs through IaaS commands"
      method_option :iaas, :alias => ["--iaas"], :type => :string, :desc => "IaaS to communicate with [VSPHERE]"
      method_option :input, :aliases => ["--input", "-i"], :type => :string, :desc => "Path to file listing valid DEAs (See Documentation)"
      method_option :config, :aliases => ["--config", "-c"], :type => :string, :desc => "Path to IaaS config YML file (See Documentation)"
      method_option :probability, :aliases => ["--probability", "-p"], :type => :numeric, :desc => "[1-100] Probablity for the Chaos Monkey to add/remove an instance (Default: 10)"
      method_option :frequency, :aliases => ["--frequency", "-f"], :type => :numeric, :desc => "Number of seconds between attempts to add/remove an instance (Default: 10)"
      def hard(probability = 10, frequency = 10)
        if (!options[:iaas] || !options[:input] || !options[:config])
          CFCM::Monkey::HardMonkey.new.show_help
        else
          if options[:probability]
            if options[:probability] < 1 || options[:probability] > 100
              puts "Probability must be between 1 and 100"
              return
            else
              probability = options[:probability]
            end
          end
          if options[:frequency]
            frequency = options[:frequency]
          end
          
          puts "Awakening the monkey on your #{options[:iaas]} infrastructure with a #{probability}% chance of chaos every #{frequency} second#{frequency > 1? "s" : ""}"
          monkey = CFCM::Monkey::HardMonkey.new(options[:iaas], options[:config], options[:input], probability, frequency)
          monkey.start
        end
      end
    end
  end
end