require 'rbvmomi'

module CFCM
  module IAAS
    class IaaS
        
      def initalize(host, user, password, config)
        @host = host
        @user = user
        @password = password
        @config = config
      end
      
      def power_off_vm(vm)
        puts "Not Implemented"
      end
        
    end
  end
end