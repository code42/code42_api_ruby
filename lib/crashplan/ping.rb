module Crashplan
  class Ping

  	attr_accessor :success

  	def initialize(attrs = {})
  		attrs ||= {}
  		self.success = attrs["success"]
  	end

  	def success?
  		self.success
  	end
  end
end
