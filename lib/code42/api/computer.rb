# Copyright (c) 2016 Code42, Inc.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
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
