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
	class Network::Timeservers
		attr_reader :network

		def initialize(network)
			@network = network
			@hash    = network.to_h
		end

		include Enumerable

		def each(&block)
			return enum_for :each unless block

			@hash["Timeservers"].each {|ip|
				block.call IPAddr.new(ip)
			}

			self
		end

		def configuration
			Configuration.new(@hash)
		end

		def configuration=(*values)
			@network.send! :SetProperty, "Timeservers.Configuration", values.flatten.map(&:to_s)
		end

		class Configuration
			def initialize(hash)
				@hash = hash
			end

			include Enumerable

			def each(&block)
				return enum_for :each unless block

				@hash["Timeservers.Configuration"].each {|ip|
					block.call IPAddr.new(ip)
				}

				self
			end
		end
	end
end
