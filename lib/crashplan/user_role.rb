module Crashplan
  class UserRole < Resource
    class << self
      def from_response(response)
        if response.is_a?(Hash) && response.has_key('data')
          data = response['data']
          self.new deserialize(data)
        end
      end

      def deserialize(data)
        result = {}
        result[:role_name] = data['roleName']
        result[:locked] = data['locked']
        result[:permissions] = data['permissions']
        result[:created_at] = data['creationDate']
        result[:updated_at] = data['modificationDate']
        result
      end
    end

    def created_at=(date)
      @created_at = DateTime.parse(date)
    end

    def updated_at=(date)
      @updated_at = DateTime.parse(date)
    end
  end
end
