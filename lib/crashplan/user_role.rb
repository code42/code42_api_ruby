module Crashplan
  class UserRole
    include Resource

    translate_attribute 'roleId', :id
    translate_attribute 'roleName', :name
    translate_attribute 'creationDate', :created_at
    translate_attribute 'modificationDate', :updated_at

    def created_at=(date)
      @created_at = DateTime.parse(date)
    end

    def updated_at=(date)
      @updated_at = DateTime.parse(date)
    end
  end
end
