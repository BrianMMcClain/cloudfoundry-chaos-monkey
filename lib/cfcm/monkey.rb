require "eventmachine"

module CFCM
  module Monkey
    class SoftMonkey      
      def initialize(session, app_name, probability, min, max)
        @session = session
        @app = @session.get_app(app_name)
      end
      
      def start
        EventMachine.run do
          EventMachine.add_periodic_timer(10) do
            puts "MONKEY!!!"
          end          
        end
      end
    end
  end
end