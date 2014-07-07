#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'hwaddr'

module Necter
	class Network::Device
		def initialize(descriptor)
			@hash = descriptor
		end

		def method
			@hash["Ethernet"]["Method"].to_sym
		end

		def address
			HWAddr.new(@hash["Ethernet"]["Address"])
		end

		def name
			@hash["Ethernet"]["Interface"]
		end

		def mtu
			@hash["Ethernet"]["MTU"]
		end
	end
end
