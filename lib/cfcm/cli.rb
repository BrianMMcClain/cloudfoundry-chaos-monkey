require "thor"

module CFCM
  module CLI
    class Command < Thor
     
      desc "soft TARGET USERNAME PASSWORD APP", "Removes/Adds instances via VMC APIs"
      method_option :min, :alias => ["--min"], :type => :numeric, :desc => "Minimum number of instances"
      method_option :max, :alias => ["--max"], :type => :numeric, :desc => "Maximum number of instances"
      def soft(target, username, password, app, min = 1, max = 5)
        "Unleashing the Chaos Monkey at #{target} under the disguise of #{username} and destroying #{app}"
      end     
    end
  end
end