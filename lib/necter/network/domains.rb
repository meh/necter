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
	class Network::Domains
		attr_reader :network

		def initialize(network)
			@network = network
			@hash    = network.to_h
		end

		include Enumerable

		def each(&block)
			return enum_for :each unless block

			@hash["Domains"].each {|name|
				block.call name
			}

			self
		end

		def configuration
			Configuration.new(@network)
		end

		def configuration=(*values)
			@network.send! :SetProperty, "Domains.Configuration",
				DBus.variant("as", values.flatten.map(&:to_s))
		end

		class Configuration
			attr_reader :network

			def initialize(network)
				@network = network
				@hash    = network.to_h
			end

			include Enumerable

			def each(&block)
				return enum_for :each unless block

				@hash["Domains.Configuration"].each {|name|
					block.call name
				}

				self
			end
		end
	end
end
