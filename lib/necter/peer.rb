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
	class Peer < Instance.for("net.connnman.Peer")
		autoload :IP, 'necter/network/ip'

		def initialize(*args)
			unless Hash === args.first
				super(args.shift)
			end

			@hash = args.shift

			@self.on_signal "PropertyChanged" do |key, value|
				@hash[key] = value
			end
		end

		def connect!
			@self.Connect
		end

		def disconnect!
			@self.Disconnect
		end

		def state
			@hash["State"].to_sym
		end

		def name
			@hash["Name"]
		end

		def ip
			IP.new(self)
		end

		def to_h
			@hash
		end
	end
end
