name             'centos_auth'
maintainer       'Phillip Mispagel'
maintainer_email 'phillip.mispagel@genesyslab.com'
license          'Apache 2.0'
description      'Configures a node to be an OpenLDAP client and sets up sudoers.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports 'redhat', '>= 6.0'
supports 'centos', '>= 6.0'
