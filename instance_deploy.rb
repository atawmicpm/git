require 'rubygems'
require 'fog'
require 'json'

#S3_KEY = 'AKIAJBYOHJYA5S6FOPTQ'
#S3_SECRET = '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'

S3_KEY = ENV['STAGE_KEY']
S3_SECRET = ENV['STAGE_SECRET']


CONN = Fog::Compute.new(provider: 'AWS', aws_access_key_id: S3_KEY, aws_secret_access_key: S3_SECRET, region: 'us-west-1')

OS = {
	'win2k8r2'				=> 'ami-ee5066ab',
	'centos6.4'				=> 'ami-08f1dd4d'
}

class Instance
	attr_accessor :name, :size, :os, :ip, :subnet, :vpc

	def initialize(args)
		@name 			= args[:name]
		@ip 				= args[:ip]
		@size 			= args[:size]
		@subnet 		= self.find_subnet @ip
		@subnet_id 	= self.find_subnet_id
		@vpc 				= CONN.vpcs.last.id
		@ami 				= OS[args[:os]]
		@sec_groups = self.find_security_groups args[:security_groups]
	end

 	def find_security_groups(groups)
 		group_ids = []
 		groups.each do |name|
 			sec = CONN.security_groups.get name
 			group_ids << sec.group_id
 		end
 		group_ids
 	end

	def find_subnet(ip)
		subnet = ip.split('.')
		subnet[-1] = '0'
		subnet.join('.')
	end

	def find_subnet_id
		CONN.subnets.each do |aws_subnet|
			return aws_subnet.subnet_id if self.find_subnet(aws_subnet.cidr_block) == self.subnet
		end
	end

	def already_exists?
		CONN.servers.each do |server|
			if server.private_ip_address == @ip
				server.tags.map {|tag| puts "#{tag[1]} (#{server.id}) already using #{@ip}. Aborting deploy." if tag[0] == "Name" }
				return true
			end
		end
		false
	end

	def deploy
		unless already_exists?
				CONN.servers.create(
							:image_id => @ami, 
							:vcp_id => @vpc, 
							:subnet_id => @subnet_id, 
							:private_ip_address => @ip,
							:flavor_id => @size,
							:security_group_ids => @sec_groups,
							:tags => {'Name' => @name}
					)
		end
	end
end


jenkins = Instance.new(name: 'Jenkins', ip: '10.52.10.50', size: 'm1.small', os: 'win2k8r2', security_groups: ['ROLE-service-client-and-internet', 'ROLE-tenant-active-directory', 'TENANT-CustomerCare'])
usw1adi_001_002 = Instance.new(name: 'Genesys Cloud Pro AD for Citrix VM 2 Tenant 001', ip: '10.51.59.13', size: 'm1.small', os: 'win2k8r2', security_groups: ['ROLE-service-client-and-internet', 'ROLE-tenant-active-directory', 'TENANT-CustomerCare'])

usw1xen_001_001 = Instance.new(name: 'Genesys Cloud Pro Citrix VM 1 Tenant 001', ip: '10.51.58.12', size: 'm1.large', os: 'win2k8r2', security_groups: ['ROLE-service-client-and-internet', 'ROLE-citrix', 'TENANT-CustomerCare'])
usw1xen_001_002 = Instance.new(name: 'Genesys Cloud Pro Citrix VM 2 Tenant 001', ip: '10.51.59.12', size: 'm1.large', os: 'win2k8r2', security_groups: ['ROLE-service-client-and-internet', 'ROLE-citrix', 'TENANT-CustomerCare'])

p usw1adi_001_001.deploy
p usw1adi_001_002.deploy
p usw1xen_001_001.deploy
p usw1xen_001_002.deploy

# selenium = Instance.new(name: 'Genesys SAAS Ops Integration Test VM', ip: '10.51.58.15', size: 'm1.small', os: 'centos6.4', security_groups: ['usw1_all_vpc_access'])
# jenkins = Instance.new(name: 'Genesys SAAS Ops Jenkins VM', ip: '10.51.58.16', size: 'm1.medium', os: 'centos6.4', security_groups: ['usw1_all_vpc_access'])

# p selenium.deploy
# p jenkins.deploy