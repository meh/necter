#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Necter
	class Agent < DBus::Object
		autoload :Request, 'necter/agent/request'
		autoload :Callbacks, 'necter/agent/callbacks'

		attr_reader :manager

		def initialize(manager, &block)
			super("/net/necter/agent#{(rand * 1_000_000).round}")

			@manager = manager

			block.call(@callbacks = Callbacks.new)

			bus     = DBus::SystemBus.instance
			service = bus.instance_variable_get(:@service)
			service.export(self)
		end

		def release
			# uguu~
		end

		def cancel
			@callbacks.call :cancel
		end

		def error(network, error)
			network = @manager.networks[network]

			@callbacks.call :error, network, error
		end

		def browser(network, url)
			network = @manager.networks[network]

			@callbacks.call :browser, network, url
		end

		def input(network, fields)
			request = Request.new(fields)
			network = @manager.networks[network]

			@callbacks.call(:input, network, request)

			[request.response]
		end

		dbus_interface "net.connman.Agent" do
			dbus_method :Release do
				release
			end

			dbus_method :Cancel do
				cancel
			end

			dbus_method :ReportError, "in service:o, in error:s" do |service, error|
				error(service, error)
			end

			dbus_method :RequestBrowser, "in service:o, in url:s" do |service, url|
				browser(service, url)
			end

			dbus_method :RequestInput, "in service:o, in fields:a{sv}, out fields:a{sv}" do |service, fields|
				input(service, fields)
			end
		end
	end
end
