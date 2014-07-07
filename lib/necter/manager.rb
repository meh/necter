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
	class Manager < Interface.for("net.connman.Manager")
		autoload :Properties, 'necter/manager/properties'
		autoload :Networks, 'necter/manager/networks'
		autoload :Technologies, 'necter/manager/technologies'

		def properties
			Properties.new(@self, *@self.GetProperties)
		end

		def networks
			Networks.new(@self.GetServices)
		end

		def peers
			@self.GetPeers.first
		end

		def technologies
			Technologies.new(@self.GetTechnologies)
		end

		def agent(&block)
			Agent.new(self, &block).tap {|agent|
				@self.RegisterAgent(agent.path)

				ObjectSpace.define_finalizer agent, agent_finalizer(agent.path)
			}
		end

		def counter(&block)
			Counter.new(self, &block).tap {|counter|
				@self.RegisterCounter(counter.path)

				ObjectSpace.define_finalizer counter, counter_finalizer(counter.path)
			}
		end

	private
		def agent_finalizer(path)
			proc {
				@self.UnregisterAgent(path)
			}
		end

		def counter_finalizer(path)
			proc {
				@self.UnregisterCounter(path)
			}
		end
	end
end
