name 'lon1'
description 'The London production environment'

cookbook_versions({
	'saas_authconfig'	=>	'= 1.0.0',
	'saas_centos_auth'			=>	'= 0.0.1'
})	
														

override_attributes({ 
	'saas_authconfig'	=> {
		'ldap'	=> {
			'enable'	=> true,
			'auth'		=> true,
			'tls'			=> true,
			'dnbase'	=> 'dc=gentn,dc=com',
			'server'	=> 'ldaps://10.51.131.16,ldaps://10.51.131.23'
		},

		'sssd'	=> {
			'enable'	=> true,
			'auth'		=> true
		},

		'pamaccess'				=> true,
		'use_autofs'			=> false
	},

	'saas_centos_auth'		=>	{
		'basedn'	=> 'dc=gentn,dc=com',
		'server'	=> 'ldaps://10.51.131.16 ldaps://10.51.131.23'
	}

})