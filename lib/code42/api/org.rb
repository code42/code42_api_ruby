module Code42
  module API
    module Org
      ### Orgs :post, :get, :put, :delete ###

      # Creates blue org as well as user for the org
      # @return [Code42::Org] The created org
      # @param attrs [Hash] A hash of attributes to assign to created org
      # @example
      #   client.create_org(:company => "test", :email => "test@test.com", :firstname => "test", :lastname => "test")
      def create_pro_org(attrs = {})
        object_from_response(Code42::Org, :post, "proOrgChannel", attrs)
      end

      # Creates an org
      # @return [Code42::Org] The created org
      # @param attrs [Hash] A hash of attributes to assign to created org
      # @example
      #   client.create_org(:name => 'Acme Org', :parent_id => 2)
      def create_org(attrs = {})
        object_from_response(Code42::Org, :post, "org", attrs)
      end

      # Returns information for a given org
      # @return [Code42::Org] The requested org
      # @param id [String, Integer] A code42 user ID
      def org(id = "my", params = {})
        object_from_response(Code42::Org, :get, "org/#{id}", params)
      end

      # Returns an org for a given name
      # @return [Code42::Org] The requested org
      # @param name [String] A Code42 org name
      # FIXME: This needs to change when the API implements a better way.
      def find_org_by_name(name)
        search_orgs(name).select { |o| o.name == name }.first
      end

      # Searches orgs for a query string
      # @return [Array] An array of matching orgs
      # @param query [String] A string to search for
      def search_orgs(query)
        orgs(q: query)
      end

      # Returns a list of up to 100 orgs
      # @return [Array] An array of matching orgs
      # @param params [Hash] A hash of parameters to match results against
      def orgs(params = {})
        params.merge!(key: 'orgs')
        objects_from_response(Code42::Org, :get, 'org', params)
      end

      def update_org(id = 'my', attrs = {})
        object_from_response(Code42::Org, :put, "org/#{id}", attrs)
      end

    end
  end
end
