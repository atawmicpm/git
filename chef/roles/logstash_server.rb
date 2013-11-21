name "logstash_server"
description "Create a logstash server."

default_attributes(
  :logstash => {
    :server => {
     	:base_config => "sbc_logstash.conf.erb"
    }
	},
	# :kibana => {
	# 	:port	=> 80
	# }
)

run_list(
	"recipe[saas_sbc_stream]",
	"recipe[logstash::server]",
	"recipe[php::module_curl]",
	"recipe[kibana]",
	"recipe[kibana::apache]"
)

