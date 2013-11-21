name 'dev-aws'
description 'The Dev AWS environment'

cookbook_versions({
	'windows'	=>	'= 1.8.0',
	'nexus'		=> '= 2.2.1',
	'saas_centos_auth'			=>	'= 0.0.1'
})	
														

override_attributes({ 
	'saas_authconfig'	=> {
		'ldap'	=> {
			'enable'	=> true,
			'auth'		=> true,
			'tls'			=> true,
			'dnbase'	=> 'dc=gentn,dc=com',
			'server'	=> 'ldaps://10.51.35.16,ldaps://10.51.35.23'
		},

		'sssd'	=> {
			'enable'	=> true,
			'auth'		=> true
		},

		'pamaccess'				=> true,
		'use_autofs'			=> false
	},
	'nexus' => {
		"external_version" => "2.4",
		"app_server_proxy" => {
			"ssl" => {
				"port" => "443"
			}
		},
		"port" => "8888"
	},
	"yum" => {
		"repos" => {
			"genip-dev-aws" => {
				"url" => "http://10.51.18.163:8080/devops/yumrepo/",
				"metadata_expire" => 60
			}
		},
		"epel_release" => "6-8"
	},

	"postgresql" => {
      "dir" => "/var/lib/pgsql9",
      "server" => {
        "service_name" => "postgresql"
      },
      "password" => {
        "postgres" => "postgres"
      }
    },


	'saas_centos_auth'		=>	{
		'basedn'	=> 'dc=gentn,dc=com',
		'server'	=> 'ldaps://10.51.35.16 ldaps://10.51.35.23'
	}

})
