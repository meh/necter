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
	class Manager::Properties
		attr_reader :state

		def initialize(manager, hash)
			@self    = manager
			@state   = hash["State"].to_sym
			@offline = hash["OfflineMode"]
			@session = hash["SessionMode"]
		end

		def online?
			not offline?
		end

		def online!
			@self.SetProperty("OfflineMode", false)
		end

		def offline?
			@offline
		end

		def offline!
			@self.SetProperty("OfflineMode", true)
		end

		def session?
			@session
		end
	end
end
