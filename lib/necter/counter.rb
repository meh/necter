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
	class Counter < DBus::Object
		attr_reader :manager

		def initialize(manager, &block)
			super("/net/necter/counter#{(rand * 1_000_000).round}")

			@manager = manager
			@block   = block

			bus     = DBus::SystemBus.instance
			service = bus.instance_variable_get(:@service)
			service.export(self)
		end

		def release
			# uguu~
		end

		def usage(network, home, roaming)
			network = @manager.networks[network]

			@block.call(network, home || roaming)
		end

		dbus_interface "net.connman.Counter" do
			dbus_method :Release do
				release
			end

			dbus_method :Usage, "in service:o, in home:a{sv}, in roaming:a{sv}" do |service, home, roaming|
				usage(service, home, roaming)
			end
		end
	end
end
