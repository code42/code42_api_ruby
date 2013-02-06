require 'date'

module Crashplan
  class User
    include Resource

    translate_attribute 'userId', :id
    translate_attribute 'userUid', :uid
    translate_attribute 'userName', :name
    translate_attribute 'creationDate', :created_at
    translate_attribute 'modificationDate', :updated_at

    def created_at=(date)
      return if date.nil?
      @created_at = DateTime.parse(date)
    end

    def updated_at=(date)
      return if date.nil?
      @updated_at = DateTime.parse(date)
    end
  end
end
