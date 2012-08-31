require "eventmachine"

module CFCM
  module Monkey
    class SoftMonkey      
      def initialize(session, app_name)
        @session = session
        
        if @session.app_exists(app_name)
          @app = @session.get_app(app_name)
        end
        
        puts @app
      end
      
      def start
        EventMachine.run do
          EventMachine.add_periodic_timer(1) do
            puts "MONKEY!!!"
          end          
        end
      end
    end
  end
end