require 'rubygems'
require 'fog'
require 'json'
require 'csv'

region = ARGV[0]

S3_KEY = 'AKIAJBYOHJYA5S6FOPTQ'
S3_SECRET = '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'
CONN = Fog::Compute.new(provider: 'AWS', aws_access_key_id: S3_KEY, aws_secret_access_key: S3_SECRET, region: region)



CSV.open("#{region}-instances.csv", "wb") do |csv|
  csv << ['name', 'ip', 'groups']

  CONN.servers.each do |server|
		name = server.tags['Name']
		ip = server.private_ip_address
		groups = server.groups
		csv << [name, ip, groups.join(' ')]
	end
end

