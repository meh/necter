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
	class Interface
		def self.for(interface)
			Class.new self do
				attr_reader :path

				define_method :initialize do |path = nil|
					@path    = path
					@bus     = DBus::SystemBus.instance
					@service = @bus["net.connman"]
					@object  = @service.object(path || "/")
					@object.introspect

					@self = @object[interface]
				end
			end
		end
	end
end
