require 'vmc'

client = VMC::Client.new("http://api.cloudfoundry.com")
client.login(ARGV[0], ARGV[1])
client.apps.each do |app|
  puts app[:name]
end