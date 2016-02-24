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
  class Role < Resource

    # @!attribute [rw] id
    #   @return [Fixnum] The id of the role
    # @!attribute [rw] name
    #   @return [String] The name of the role
    # @!attribute [rw] permissions
    #   @return [Array] A list of permissions for this role
    # @!attribute [rw] created_at
    #   @return [DateTime] The timestamp for the time the role was assigned
    # @!attribute [rw] updated_at
    #   @return [DateTime] The timestamp for the time the role was updated

    attribute :id, :from => :roleId
    attribute :name, :from => :roleName
    attribute :created_at, :from => :creationDate, :as => DateTime
    attribute :updated_at, :from => :modificationDate, :as => DateTime
    attribute :permissions

    def permissions=(permissions = [])
      @permissions = permissions.map { |p| p['permission'] }
    end

    def update(attrs = {})
      client.update_role(id, attrs)
    end

    def delete
      client.delete_role(id)
    end
  end
end
