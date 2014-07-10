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
	class Network < Interface.for("net.connman.Service")
		autoload :IP, 'necter/network/ip'
		autoload :Nameservers, 'necter/network/nameservers'
		autoload :Timeservers, 'necter/network/timeservers'
		autoload :Domains, 'necter/network/domains'
		autoload :Device, 'necter/network/device'

		def initialize(*args)
			unless Hash === args.first
				super(args.shift)
			end

			@hash = args.shift
		end

		def connect!
			@self.Connect
		end

		def disconnect!
			@self.Disconnect
		end

		def remove!
			@self.Remove
		end

		def auto_connect=(value)
			@self.SetProperty("AutoConnect", value)
		end

		def name
			@hash["Name"]
		end

		def device
			Device.new(self)
		end

		def type
			@hash["Type"].to_sym
		end

		def ip
			IP.new(self)
		end

		def nameservers
			Nameservers.new(self)
		end

		def timeservers
			Timeservers.new(self)
		end

		def domains
			Domains.new(self)
		end

		def security
			@hash["Security"].map(&:to_sym)
		end

		def state
			@hash["State"].to_sym
		end

		def online?
			state == :online
		end

		def strength
			@hash["Strength"]
		end

		def favorite?
			@hash["Favorite"]
		end

		def immutable?
			@hash["Immutable"]
		end

		def auto_connect?
			@hash["AutoConnect"]
		end

		def to_h
			@hash
		end

		def inspect
			"#<#{self.class}: #{@hash.inspect}>"
		end
	end
end
