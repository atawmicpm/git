name "centos_base"
description "Base role applied to all CentOS 6+ nodes."

run_list(

	"recipe[saas_centos_auth]",
	"recipe[saas_authconfig]"

)

