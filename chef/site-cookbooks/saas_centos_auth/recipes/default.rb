# Install OpenLDAP on CentOS
package "openldap-clients" do
  action :upgrade
end

template "/etc/openldap/ldap.conf" do
  user "root"
  group "root"
  source "ldap.conf.erb"
end

# Sudoers
template "/etc/sudoers" do
	user "root"
	group "root"
	mode "0440"
	source "sudoers.erb"
end

template "/etc/sudoers.d/genesys" do
	user "root"
	group "root"
	mode "0440"
	source "sudoers.genesys.erb"
end