module Crashplan
  class Ping

  	attr_accessor :success

  	def initialize(attrs = {})
  		attrs ||= {}
  		self.success = attrs["success"]
  	end
  end
end
