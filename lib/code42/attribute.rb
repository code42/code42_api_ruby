module Code42
  class Attribute
    attr_reader :name, :from, :as, :collection
    alias_method :to, :name

    def initialize(name, options = {})
      @name = name.to_sym
      @from = (options[:from] || name.to_s.camelize(:lower)).to_s
      @as   = options[:as]
      @collection = options[:collection]
    end
  end
end
