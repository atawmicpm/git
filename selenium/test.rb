require 'erb'
require 'open3'
require 'sidekiq'

type	= ARGV[0]
url		= ARGV[1]
user	= ARGV[2]
pass	= ARGV[3]

class Template
	attr_accessor :type, :url, :user, :pass
	def template_binding
		binding
	end
end

class WebTest
	include Sidekiq::Worker
	def perform(type, url, user, pass)
		sleep 1
		test_file = File.open("./#{type}.feature", "w+")
		template = File.read("./#{type}.erb")

		feature = Template.new
		feature.type 	= type
		feature.url	= url
		feature.user	= user
		feature.pass 	= pass

		test_file << ERB.new(template).result(feature.template_binding)
		test_file.close

		Open3.popen2e( 'cucumber' ) do |stdin, stdout_and_stderr, wait_thr|
  			pid = wait_thr.pid
			exit_status = wait_thr.value

			"run zabbix_sender" if exit_status.success?
		end
	end
end

WebTest.perform_async(type, url, user, pass)