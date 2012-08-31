require "eventmachine"

module CFCM
  module Monkey
    class SoftMonkey      
      def initialize(session, app_name, probability, min, max)
        @session = session
        @app_name = app_name
        @app = @session.get_app(app_name)
        @probability = probability
        @min_instances = min
        @max_instances = max
      end
      
      def start
        EventMachine.run do
          EventMachine.add_periodic_timer(1) do
            # Determine if we should unleash the monkey
            if (Random.rand(100) + 1) <= @probability
              app = @app
              instances = app[:instances]
              max_instances = @session.max_instance_growth(@app_name)
              if max_instances == 0 || @max_instances == instances
                # Shrink
                puts "Shrink due to instance limitations"
              elsif instances == @min_instances
                # Grow
                puts "Grow due to instance limitations"
              elsif Random.rand(2) == 0
                # Shrink
                puts "Shrink due to randomness"
              else
                #Grow
                puts "Grow due to randomness"
              end                
            end
          end          
        end
      end
    end
  end
end