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
	class Technology < Interface.for("net.connman.Technology")
		def initialize(*args)
			unless Hash === args.first
				super(args.shift)
			end

			@hash = args.shift
		end

		def name
			@hash["Name"]
		end

		def type
			@hash["Type"].to_sym
		end

		def powered?
			@hash["Powered"]
		end

		def powered=(value)
			@self.SetProperty("Powered", value)
		end

		def connected?
			@hash["Connected"]
		end

		def tethering?
			@hash["Thethering"]
		end

		def scan!
			@self.Scan
		end
	end
end
