require 'rbvmomi'

module CFCM
  module IAAS
    class IaaS
        
      def initalize(host, user, password)
        @host = host
        @user = user
        @password = password
      end
      
      def power_off_vm(datacenter, vm)
        puts "Not Implemented"
      end
        
    end
  end
end