require 'vmc'

module CFCM
  module CF
    class Session    
      def initialize(target, username, password)
        begin
          @client = VMC::Client.new(target)
          @client.login(username, password)
        rescue
          puts "Could not login!"
          #TODO: Handle error
          return
        end
      end
      
      def get_app(app_name)
        if !@client
          puts "Must be loged in"
          #TODO: Handle error
          return
        end
        
        @client.apps.each do |app|
          if app[:name] == app_name
            return app
          end
        end
        
        puts "Application Not Found"
        #TODO: Handle error
        return nil
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
        app_memory = app[:resources][:memory]
        
        max_new_instances = (remaining_memory / app_memory).floor
        return max_new_instances
      end
    end
  end
end