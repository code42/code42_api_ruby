module Crashplan
  class UserRoleCollection
    include Enumerable

    def initialize(roles = [])
      @roles = roles
    end

    def each(&block)
      @roles.each do |role|
        if block_given?
          block.call role
        else
          yield role
        end
      end
    end

    def includes_id?(id)
      map(&:id).include? id
    end

    def includes_name?(name)
      map(&:name).include? id
    end
  end
end
