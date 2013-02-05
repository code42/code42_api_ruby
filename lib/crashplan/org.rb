module Crashplan
  class Org
    include Resource

    translate_attribute "orgId", :id
    translate_attribute "orgUid", :uid
    translate_attribute "orgName", :name
    translate_attribute "parentOrgId", :parent_id
    translate_attribute "creationDate", :created_at
    translate_attribute "modificationDate", :updated_at

    class << self
      def from_response(response)
        if response.has_key?('data')
          self.new deserialize(response['data'])
        end
      end
    end

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
