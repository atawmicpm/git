#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'aws-sdk'

#S3_KEY = ENV['S3_KEY']
#S3_SECRET = ENV['S3_SECRET']
# saas-us@genesyslab.com   G3n3s7saws

S3_KEY = ENV['STAGE_KEY']
S3_SECRET = ENV['STAGE_SECRET']

CONN = AWS::EC2.new({
  :access_key_id => S3_KEY,
  :secret_access_key => S3_SECRET,
  :region => 'us-west-1'
  })


subnets = %w(
10.52.0.0/24
10.52.1.0/24
10.52.2.0/24
10.52.3.0/24
10.52.4.0/24
10.52.5.0/24
10.52.6.0/24
10.52.7.0/24
10.52.8.0/24
10.52.9.0/24
10.52.10.0/24
10.52.11.0/24
10.52.12.0/24
10.52.13.0/24
10.52.14.0/24
10.52.15.0/24
)

# subnets.each {|subnet| p subnet }
#vpc = CONN.vpcs.create('10.52.0.0/20')
#puts "vpc = #{vpc}"

route_table = CONN.route_tables.first
#route_table = CONN.route_tables.create({:vpc => vpc})

# subnets.each {|subnet| 
#   s = CONN.subnets.create(subnet, {:vpc => vpc}) 
#   s.set_route_table route_table
# }

CONN.subnets.each {|s| p s.set_route_table route_table }


# Customer Gateways

# ID
# State
# Type
# IP Address
# BGP ASN
# VPC
  
# cgw-046d3d41
# available iconavailable
# ipsec.1
# 208.79.168.8
# 65000
 

# cgw-d3cc9c96
# available iconavailable
# ipsec.1
# 135.39.128.253
# 65445
# vpc-774c111e (10.51.48.0/20)

# cgw-d2cc9c97
# available iconavailable
# ipsec.1
# 135.39.128.254
# 65445
# vpc-774c111e (10.51.48.0/20)


# Virtual Private Gateways
# ID
# State
# Type
# VPC
# IDStateTypeVPC

# vgw-786e3e3d
# available iconavailable
# ipsec.1
# vpc-774c111e (10.51.48.0/20)

# VPN

# ID
# State
# Virtual Private Gateway
# Customer Gateway
# Type
# VPC
# Routing

# vpn-05cf9f40 iconvpn-05cf9f40
# available
# vgw-786e3e3d
# cgw-d3cc9c96
# ipsec.1
# vpc-774c111e (10.51.48.0/20)
# Dynamic

# vpn-04cf9f41 iconvpn-04cf9f41
# available
# vgw-786e3e3d
# cgw-d2cc9c97
# ipsec.1
# vpc-774c111e (10.51.48.0/20)
# Dynamic



