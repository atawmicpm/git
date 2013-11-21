def domain_or_replica?(hostname)
	return "Domain" if hostname.split('-')[-1] == '001'
	return "Replica"
end

def name_servers(ipaddress)
	ip = ipaddress.split('.')

	# if it is a xenapp host, the nameservers need to be the ad hosts
	# if it is an ad host, the nameservers need to be themselves, but change
	ip[3] = ip[3].to_i
	ip[2] = ip[2].to_i

	ip[3] += 1 if ip[3] % 2 == 0
	ip[2] -= 1 if ip[2] % 2 == 1
	"'#{ip.join('.')}','10.51.35.5'"
end

