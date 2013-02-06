module Crashplan
  class UserRole
    include Resource

    class << self
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
