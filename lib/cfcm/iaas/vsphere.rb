require 'rbvmomi'

module CFCM
  module IAAS
    class Vsphere
        
      def initialize(host, user, password, config)
        @host = host
        @user = user
        @password = password
        @config = config
      end
      
      def power_off_vm(vm_name)
        opts = {:host=>@host, :user=>@user, :password=>@password, :insecure=>true}
        vim = RbVmomi::VIM.connect opts
        dc = vim.serviceInstance.content.rootFolder.traverse(config["datacenter"], RbVmomi::VIM::Datacenter) or abort "datacenter not found"
        vm = dc.vmFolder.traverse(vm_name, VIM::VirtualMachine) or abort "VM not found"
        vm.PowerOffVM_Task.wait_for_completion
      end
        
    end
  end
end