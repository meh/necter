#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dbus'

module Necter
	def self.daemon?
		DBus::SystemBus.instance["net.connman"].object('/').introspect
	rescue DBus::Error
		false
	else
		true
	end

	autoload :Interface, 'necter/interface'
	autoload :Manager, 'necter/manager'
	autoload :Agent, 'necter/agent'
	autoload :Counter, 'necter/counter'
	autoload :Network, 'necter/network'
	autoload :Technology, 'necter/technology'
end
