
sbc_dir = "/usr/local/bin/sbc_udp_stream"

directory sbc_dir do
	owner "root"
	group "root"
	mode "0755"
	action :create
end

directory "/var/log/sbc" do
	owner "root"
	group "root"
	mode "0644"
	action :create
end

template "#{sbc_dir}/udpsrv.pl" do
	source "udpsrv.pl.erb"
	mode "0644"
	owner "root"
	group "root"
	notifies :restart, "service[sbc_stream]"
end

template "/etc/init/sbc_stream.conf" do
	source "sbc_stream.conf.erb"
	mode "0644"
	owner "root"
	group "root"
end

service "sbc_stream" do
	provider Chef::Provider::Service::Upstart
	supports :status => true, :restart => true, :reload => true
	action [:enable, :start]
end

template "#{sbc_dir}/gzip_SBC_logs.sh" do
	source "gzip_SBC_logs.sh.erb"
	mode "0744"
	owner "root"
	group "root"
end

cron "elasticsearch_cleanup" do
	minute "33"
	hour "0"
	command "/usr/bin/curl -XDELETE http://localhost:9200/logstash-`date -d '30 days ago' +%Y.%m.%d`"
	action :create
end

cron "gzip_sbc_logs" do
	minute "*/10"
	command "/usr/bin/flock -n /tmp/gzip_SBC_logs.lock #{sbc_dir}/gzip_SBC_logs.sh"
	action :create
end

cron "rm_sbc_logs" do
	minute "25"
	hour "0"
	command '/usr/bin/find /var/log/sbc -type f -name "*.log.gz" -mtime +30 -exec /bin/rm -f {} \;'
	action :create
end