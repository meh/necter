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
		attr_reader :manager

		def initialize(manager, hash)
			@manager = manager
			@hash    = hash
		end

		def state
			@hash["State"].to_sym
		end

		def online?
			not offline?
		end

		def online!
			@self.SetProperty("OfflineMode", false)
		end

		def offline?
			@hash["OfflineMode"]
		end

		def offline!
			@self.SetProperty("OfflineMode", true)
		end

		def session?
			@hash["SessionMode"]
		end
	end
end
