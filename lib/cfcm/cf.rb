require 'cfoundry'

module CFCM
  module CF
    class Session    
      def initialize(target, username, password)
        begin
          @client = CFoundry::V1::Client.new(target)
          @client.login({:username => username, :password => password})
        rescue => e
          raise e
          #puts "Could not login!"
          #TODO: Handle error
          return
        end
      end
      
      def is_logged_in
        return @client.logged_in?
      end
      
      def get_app(app_name)
        if !@client
          puts "Must be loged in"
          #TODO: Handle error
          return
        end
        
        return @client.app_by_name(app_name)
        return nil
      end
      
      def app_exists(app_name)
        app = self.get_app(app_name)
        return app != nil
      end
      
      def remaining_memory
        if !@client
          puts "Must be loged in"
          #TODO: Handle error
          return
        end
                
        info = @client.info
        return info[:limits][:memory] - info[:usage][:memory]
      end
      
      def max_instance_growth(app_name)
        if !@client
          puts "Must be loged in"
          #TODO: Handle error
          return
        end
        
        remaining_memory = self.remaining_memory
        app = self.get_app(app_name)
        app_memory = app.memory
        
        max_new_instances = (remaining_memory / app_memory).floor
        return max_new_instances
      end
      
      def add_instance(app)
        app.total_instances += 1
        app.update!
        return self.get_app(app.name)
      end
      
      def remove_instance(app)
        app.total_instances -= 1
        app.update!
        return self.get_app(app.name)
      end
      
    end
  end
end