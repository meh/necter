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
	class Agent::Callbacks
		def initialize
			@hash = {}
		end

		%i[cancel error browser input].each {|name|
			define_method name do |&block|
				@hash[name] = block
			end
		}

		def call(name, *args)
			if block = @hash[name]
				block.call(*args)
			end
		end
	end
end
