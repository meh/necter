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
	class Agent::Request
		attr_reader :response

		def initialize(hash)
			@hash     = hash
			@response = {}
		end

		def ssid?
			@hash.keys.include? "SSID"
		end

		def ssid=(value)
			@response["SSID"] = value
		end

		def error?
			@hash.keys.include? "PreviousPassphrase"
		end

		def passphrase?
			@hash.keys.include? "Passphrase"
		end

		def challenge?
			@hash["Passphrase"]["Type"] == "response"
		end
		
		def passphrase=(value)
			@response["Passphrase"] = value
		end

		def identity?
			@hash.keys.include? "Identity"
		end

		def identity=(value)
			@response["Identity"] = value
		end

		def password?
			@response.keys.include? "Password"
		end

		def password=(value)
			@response["Password"] = value
		end

		def username?
			@response.keys.include? "Username"
		end

		def username=(value)
			@response["Username"] = value
		end

		def to_h
			@hash
		end

		def inspect
			"#<#{self.class}: #{@hash.inspect}>"
		end
	end
end
