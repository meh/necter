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
	class Manager::Networks
		attr_reader :manager

		def initialize(manager, list)
			@manager = manager
			@list    = list.map {|path, descriptor|
				Network.new(path, descriptor)
			}
		end

		include Enumerable

		def each(&block)
			return enum_for :each unless block

			@list.each(&block)

			self
		end

		def [](value)
			if Integer === value
				to_a[value]
			else
				by_path(value) || by_name(value)
			end
		end

		def by_path(path)
			find {|net|
				net.path == path
			}
		end

		def by_name(name)
			find {|net|
				net.name == name
			}
		end
	end
end
