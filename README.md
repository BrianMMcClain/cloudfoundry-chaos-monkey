#cloudfoundry-chaos-monkey

Chaos Monkey style service for Cloud Foundry

##Using Cloud Foundry Chaos Monkey

First off, grab the Cloud Foundry Chaos Monkey gem

```gem install cfcm```

and then unleash the monkey! 

### Soft Mode
Soft mode will simply remove/add instances at random. This uses the standard VMC APIs and you can specify the minimum and maximum number of instances the app may have.

In this example, we'll use CFCM on an application named `myapp`, keeping between 2 and 5 instances. We want CFCM to have a 30% chance of adding or removing an instance every 10 seconds. Adding and removeing instances is known as "soft mode", that is, this is equvilant to doing "vmc instane [app] -1".

```cfcm soft [email] [password] myapp --min 2 --max 5 -p 30 -f 10```

### Hard Mode

Hard mode gets a bit more bananas. BOSH-inspired, there is an IaaS-layer shim that sits between CFCM and your virtual machines. Currently, the following IaaS layers are supported...

- vSphere

and the following are planned...

- AWS
- OpenStack
- BOSH (I realize this is a bit odd, but this will allow some interesting things in addition to straight IaaS)

As with BOSH, my goal is to allow the community to add their on IaaS layer. There's simply two commands that will be needed though; Power On and Power Off

There are two files that will be needed to run Hard Mode, a config file and an input file. The config file will contain the configuration specific to the IaaS you're targeting. The input file will list the VMs that are valid targets for CFCM. For vSphere, an example ```config.yml``` file would look like...

<pre>
host: 127.0.0.1
user: john_doe
password: p@ssw0rd
datacenter: Monkey Island
</pre>

and a sample ```input.list``` file would look like...

<pre>
cf-cfcm-testing-dea-001
cf-cfcm-testing-dea-002
cf-cfcm-testing-dea-003
cf-cfcm-testing-dea-004
cf-cfcm-testing-dea-005
</pre>

Note: These don't JUST have to be DEAs. Really, CFCM could be used to rip VMs out from any distributed systems. This could be other pieces of Cloud Foundry (Service Gateways, Cloud Controllers, Routers, etc.) or for something completely unrelated to Cloud Foundry (AD servers? Replica database servers?)

Then to unleash the monkey on your infrastructure, attempting to hit the VMs every 10 seconds with a 30% chance of taking out a VM, run...

```cfcm hard --iaas vsphere -c config.yml -i input.list -f 10 -p 30```

## To-Do

- Implement the remaining IaaS layers
- Provide a proper interface for the community to insert an IaaS layer
- Add the ability to specify min/max VMs to be powered on for Hard Mode, including if we should power VMs back on (i.e. We shut down a DEA last time, let's power it back on and power off a Router)