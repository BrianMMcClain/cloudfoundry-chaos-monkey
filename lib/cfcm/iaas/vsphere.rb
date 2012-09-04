require 'rbvmomi'

module CFCM
  module IAAS
    class vSphere
        
      def initalize(host, user, password)
        @host = host
        @user = user
        @password = password
      end
      
      def power_off_vm(datacenter, vm)
        vim = VIM.connect {:host=>@host, :user=>@user, :password=>@password, :insecure=>true}
        dc = vim.serviceInstance.content.rootFolder.traverse(datacenter, VIM::Datacenter) or abort "datacenter not found"
        vm = dc.vmFolder.traverse(vm, VIM::VirtualMachine) or abort "VM not found"
        vm.PowerOffVM_Task.wait_for_completion
      end
        
    end
  end
end