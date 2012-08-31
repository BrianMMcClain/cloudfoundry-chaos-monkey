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
          EventMachine.add_periodic_timer(10) do
            # Determine if we should unleash the monkey
            if (Random.rand(100) + 1) <= @probability
              @app = @session.get_app(@app_name)
              instances = @app[:instances]
              max_growth = @session.max_instance_growth(@app_name)
              
              puts @max_instances
              puts instances
              
              if instances > @max_instances
                puts "Shrink due to instance limitations"
                @app = @session.remove_instance(@app)
              elsif instances < @min_instances
                puts "Grow due to instance limitations"
                @app = @session.add_instance(@app)
              elsif max_growth == 0 || @max_instances == instances
                # Shrink
                puts "Shrink due to instance limitations"
                @app = @session.remove_instance(@app)
              elsif instances == @min_instances
                # Grow
                puts "Grow due to instance limitations"
                @app = @session.add_instance(@app)
              elsif Random.rand(2) == 0
                # Shrink
                puts "Shrink due to randomness"
                @app = @session.remove_instance(@app)
              else
                #Grow
                puts "Grow due to randomness"
                @app = @session.add_instance(@app)
              end
            end
          end          
        end
      end
    end
  end
end