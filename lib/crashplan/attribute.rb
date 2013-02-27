module Crashplan
  class Attribute
    attr_reader :name, :from, :as
    alias_method :to, :name

    def initialize(name, options = {})
      @name = name.to_sym
      @from = options[:from].to_s
      @as   = options[:as]
    end
  end
end
