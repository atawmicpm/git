#Install Options
default[:saas_citrix][:script_dir] = 'C:/scripts'
default[:saas_citrix][:admin_pw] = 'NewS3cr3t32u3er!' # move to encrypted databag
default[:saas_citrix][:domain] = 'tenant001.glbl.genprim.com'
default[:saas_citrix][:farm] = 'Tenant001'
default[:saas_citrix][:tenant] = 'CustomerCare'

default[:saas_citrix][:ad1][:hostname] = 'usw1adi-001-001'
default[:saas_citrix][:ad2][:hostname] = 'usw1adi-001-002'
default[:saas_citrix][:ad1][:ip] = '10.51.58.13'
default[:saas_citrix][:ad2][:ip] = '10.51.59.13'

default[:saas_citrix][:xa1][:hostname] = 'usw1xen-001-001'
default[:saas_citrix][:xa2][:hostname] = 'usw1xen-001-002'
default[:saas_citrix][:xa1][:ip] = '10.51.58.12'
default[:saas_citrix][:xa2][:ip] = '10.51.59.12'


default[:saas_citrix][:storefront][:int] = 'https://tenant001-ctx-int.genesyscloud.com'
default[:saas_citrix][:storefront][:url1] = 'https://customercare-citrix.genesyscloud.com'
default[:saas_citrix][:storefront][:url2] =  'https://tenant001-ctx.genesyscloud.com'