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
require 'ipaddr'

module Necter
	class Network::Nameservers
		def initialize(network, descriptor)
			@self = network
			@hash = descriptor
		end

		include Enumerable

		def each(&block)
			return enum_for :each unless block

			@hash["Nameservers"].each {|ip|
				block.call IPAddress.new(ip)
			}

			self
		end

		def configuration
			Configuration.new(@hash)
		end

		def configuration=(*values)
			@self.SetProperty("Nameservers.Configuration", servers.flatten.map(&:to_s))
		end

		class Configuration
			def initialize(hash)
				@hash = hash
			end

			include Enumerable

			def each(&block)
				return enum_for :each unless block

				@hash["Nameservers.Configuration"].each {|ip|
					block.call IPAddress.new(ip)
				}

				self
			end
		end
	end
end
