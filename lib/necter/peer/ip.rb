#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'ipaddr'

module Necter
	class Peer::IP
		attr_reader :peer

		def initialize(peer)
			@peer = peer
			@hash = peer.to_h
		end

		def address
			IPAddr.new(@hash["IPv4"]["Address"])
		end

		def netmask
			IPAddr.new(@hash["IPv4"]["Netmask"])
		end
	end
end
