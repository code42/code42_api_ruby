module Crashplan
  class Resource
    def initialize(data = {})
      data.each do |key, value|
        self.class.send :define_method, "#{key}=".to_sym do |v|
          instance_variable_set("@" + key.to_s, v)
        end
        self.class.send :define_method, key.to_sym do
          instance_variable_get("@" + key.to_s)
        end
        self.send("#{key}=", value)
      end
    end
  end
end
