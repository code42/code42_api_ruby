module Code42
  module API
    module Computer
      ### Computers :get, :put  ###

      # Returns one computer or http status 404
      # @return [Code42::Computer] The requested computer
      # @param id [String, Integer] A computer ID
      def computer(id, params = {})
        object_from_response(Code42::Computer, :get, "computer/#{id}", params)
      end

      # Returns a list of computers
      # @return [Array] The list of computers
      # @param params [Hash] A hash of valid search parameters for computers
      def computers(params = {})
        params.merge!(key: 'computers')
        objects_from_response(Code42::Computer, :get, 'computer', params)
      end


      # Block a computer from backing up
      # @return [Code42::Computer] The blocked computer
      # @params id [Integer, String] The computer ID you want to block
      def block_computer(id)
        put("computerblock/#{id}")
      end

      def unblock_computer(id)
        delete("computerblock/#{id}")
      end
    end
  end
end
