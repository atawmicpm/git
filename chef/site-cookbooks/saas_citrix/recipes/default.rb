include_recipe 'windows::reboot_handler'

# -------------------------
# Basic steps
# -------------------------

directory node[:saas_citrix][:script_dir] do
	action :create
end

template "#{node[:saas_citrix][:script_dir]}/saas.ps1" do
	source 'saas.ps1.erb'
	variables({
		:hostname => Chef::Config[:node_name],
		:name_servers => name_servers(node['ipaddress'])
		})
end

template "#{node[:saas_citrix][:script_dir]}/functions.ps1" do
	source 'functions.ps1.erb'
end

windows_reboot 5 do
	reason 'chef reboot'
	timeout 5
	action :nothing
end

# -------------------------
# XenApp steps
# -------------------------

if Chef::Config[:node_name] =~ /xen/

	template "#{node[:saas_citrix][:script_dir]}/setup.ps1" do
		source 'setup_xa.ps1.erb'
		variables({
			:hostname => Chef::Config[:node_name],
			:xa1	=> node[:saas_citrix][:xa1][:hostname]
		})
	end

	template "#{node[:saas_citrix][:script_dir]}/storefront.ahk" do
		source 'storefront_create.ahk.erb' if Chef::Config[:node_name] == node[:saas_citrix][:xa1][:hostname]
		source 'storefront_join.ahk.erb' if Chef::Config[:node_name] == node[:saas_citrix][:xa2][:hostname]
	end

end

# -------------------------
# Active Directory steps
# -------------------------

if Chef::Config[:node_name] =~ /adi/

	template "#{node[:saas_citrix][:script_dir]}/setup.ps1" do
			source 'setup_ad.ps1.erb'
	end

	template "#{node[:saas_citrix][:script_dir]}/dcpromo.txt" do
		source 'dcpromo.txt.erb'
		variables({
			:domain_or_replica => domain_or_replica?(Chef::Config[:node_name])
		})
		action :create
	end

	windows_feature 'DFS-Replication-All' do
		:install
	end

	windows_feature 'DfsMgmt' do
		:install
	end
end

# -------------------------
# Initiate setup
# -------------------------

powershell_script "#{node[:saas_citrix][:script_dir]}/setup.ps1" do
	flags "-File #{node[:saas_citrix][:script_dir]}/setup.ps1"
	action :run
	notifies :request, 'windows_reboot[5]'
end


