module Crashplan
  class Org
    attr_accessor :id, :uid, :name, :status, :active, :blocked, :parent_id, :type, :created_at, :updated_at

    def initialize(attrs = {})
      attrs ||= {}
      self.id         = attrs["orgId"]
      self.uid        = attrs["orgUid"]
      self.name       = attrs["orgName"]
      self.status     = attrs["status"]
      self.active     = attrs["active"]
      self.blocked    = attrs["blocked"]
      self.parent_id  = attrs["parentOrgId"]
      self.type       = attrs["type"]
      self.created_at = attrs["creationDate"]
      self.updated_at = attrs["modificationDate"]
    end

    class << self
      def from_response(response)
        if response.has_key?('data')
          self.new(response['data'])
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
