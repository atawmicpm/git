include_recipe "ubuntu"
include_recipe "rvm::system"

user "selenium" do
  supports :manage_home => true
  home "/home/selenium"
  shell "/bin/bash"
end

packages = %w(xvfb zabbix-agent firefox redis-server openjdk-7-jre-headless lighttpd)

packages.each do |name|
	package name do
		action :install
	end
end

remote_file "/usr/local/bin/selenium-server-standalone-2.37.0.jar" do
  source "http://selenium.googlecode.com/files/selenium-server-standalone-2.37.0.jar"
end

folders = %w(features features/support templates logs)

folders.each do |folder|
	directory "/home/selenium/#{folder}" do
		owner "selenium"
		group "selenium"
		mode "0775"
		action :create
	end
end

template "/etc/init/xvfb.conf" do
	source "xvfb.conf.erb"
	mode "0644"
	owner "root"
	group "root"
end

template "/usr/bin/xvfb-run" do
	source "xvfb-run.erb"
	mode "0755"
	owner "root"
	group "root"
end

template "/etc/init/sidekiq.conf" do
	source "sidekiq.conf.erb"
	mode "0644"
	owner "root"
	group "root"
end

template "/home/selenium/features/selenium_steps.rb" do
	source "selenium_steps.rb.erb"
	mode "0755"
	owner "selenium"
	group "selenium"
end

template "/home/selenium/features/support/env.rb" do
	source "env.rb.erb"
	mode "0755"
	owner "selenium"
	group "selenium"
end

tmpls = %w(cim gax citrix wfm ops gi2)

tmpls.each do |tmpl|
	template "/home/selenium/templates/#{tmpl}.erb" do
		source "#{tmpl}.erb"
		mode "0644"
		owner "selenium"
		group "selenium"
	end
end

template "/usr/bin/webtest" do
	source "webtest.erb"
	mode "0644"
	owner "root"
	group "root"
end

template "/home/selenium/webtest.rb" do
	source "webtest.rb.erb"
	mode "0775"
	owner "selenium"
	group "selenium"
end

template "/home/selenium/.lighttpdpassword" do
	source "lighttpdpassword.erb"
	mode "0775"
	owner "selenium"
	group "selenium"
end

service "lighttpd" do
	action :nothing
end

template "/etc/lighttpd/lighttpd.conf" do
	source "lighttpd.conf.erb"
	mode "0644"
	owner "root"
	group "root"
	notifies :restart, "service[lighttpd]", :delayed
end

template "/etc/sudoers.d/selenium" do
	source "selenium.sudoers.erb"
	mode "0440"
	owner "root"
	group "root"
end

service "zabbix-agent" do
	action :nothing
end

template "/etc/zabbix/zabbix_agentd.conf" do
	source "zabbix_agentd.conf.erb"
	mode "0644"
	owner "root"
	group "root"
	notifies :restart, "service[zabbix-agent]", :delayed
end

service "xvfb" do
	provider Chef::Provider::Service::Upstart
	supports :status => true, :restart => true, :reload => true
	action [:enable, :start]
end

service "sidekiq" do
	provider Chef::Provider::Service::Upstart
	supports :status => true, :restart => true, :reload => true
	action [:enable, :start]
end

