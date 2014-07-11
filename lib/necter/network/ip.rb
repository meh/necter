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
	class Network::IP
		attr_reader :network, :version

		def initialize(network, version = nil)
			@network = network
			@hash    = network.to_h
			@version = version
		end

		def v4?
			@version == 4
		end

		def v4
			self.class.new(@network, 4)
		end

		def v6
			self.class.new(@network, 6)
		end

		def v6?
			@version == 6
		end

		def configuration
			Configuration.new(@network, @version)
		end

		def address
			if @version
				if @hash["IPv#@version"]["Address"]
					IPAddr.new(@hash["IPv#@version"]["Address"])
				end
			else
				IPAddr.new(@hash["IPv4"]["Address"] || @hash["IPv6"]["Address"])
			end
		end

		def netmask
			if @version
				@hash["IPv#@version"]["Netmask"]
			else
				@hash["IPv4"]["Netmask"] || @hash["IPv6"]["Netmask"]
			end
		end

		def gateway
			if @version
				if @hash["IPv#@version"]["Gateway"]
					IPAddr.new(@hash["IPv#@version"]["Gateway"])
				end
			else
				IPAddr.new(@hash["IPv4"]["Gateway"] || @hash["IPv6"]["Gateway"])
			end
		end
		
		class Configuration
			attr_reader :network, :version

			def initialize(network, version)
				@network = network
				@hash    = network.to_h
				@version = version
			end

			def save!
				@network["IPv#{@version || 4}.Configuration"] =
					@hash["IPv#{@version || 4}.Configuration"]
			end

			def method=(value)
				if @hash["IPv#{@version || 4}.Configuration"]["Method"] != value.to_s
					@hash["IPv#{@version || 4}.Configuration"] = { "Method" => value.to_s }
				end
			end

			def method
				if @version
					@hash["IPv#@version.Configuration"]["Method"]
				else
					@hash["IPv4.Configuration"]["Method"] || @hash["IPv6.Configuration"]["Method"]
				end.to_sym
			end

			def address=(value)
				@hash["IPv#{@version || 4}.Configuration"]["Address"] = value.to_s
			end

			def address
				if @version
					if @hash["IPv#@version.Configuration"]["Address"]
						IPAddr.new(@hash["IPv#@version.Configuration"]["Address"])
					end
				else
					IPAddr.new(@hash["IPv4.Configuration"]["Address"] ||
					           @hash["IPv6.Configuration"]["Address"])
				end
			end

			def netmask=(value)
				@hash["IPv#{@version || 4}.Configuration"]["Netmask"] = value.to_s
			end

			def netmask
				if @version
					@hash["IPv#@version.Configuration"]["Netmask"]
				else
					@hash["IPv4.Configuration"]["Netmask"] ||
					@hash["IPv6.Configuration"]["Netmask"]
				end
			end

			def gateway=(value)
				@hash["IPv#{@version || 4}.Configuration"]["Gateway"] = value.to_s
			end

			def gateway
				if @version
					if @hash["IPv#@version.Configuration"]["Gateway"]
						IPAddr.new(@hash["IPv#@version.Configuration"]["Gateway"])
					end
				else
					IPAddr.new(@hash["IPv4.Configuration"]["Gateway"] ||
					           @hash["IPv6.Configuration"]["Gateway"])
				end
			end

			def privacy
				if @version == 4
					raise ArgumentError, "no privacy settings for IPv4"
				end

				@hash["IPv6.Configuration"]["Privacy"].to_sym
			end

			def privacy?
				privacy != :disabled
			end
		end
	end
end
