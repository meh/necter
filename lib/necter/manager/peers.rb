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
	class Manager::Peers
		attr_reader :manager

		def initialize(manager, list)
			@manager = manager
			@list    = list.map {|path, descriptor|
				Peer.new(path, descriptor)
			}
		end
	end
end
