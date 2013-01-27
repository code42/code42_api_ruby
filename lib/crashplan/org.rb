module Crashplan
  class Org
    attr_accessor :name

    def initialize(attrs = {})
      attrs ||= {}
      @name = attrs["orgName"]
    end
  end
end
