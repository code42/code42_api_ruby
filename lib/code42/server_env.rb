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
  class ServerEnv < Resource
    attribute :version
    attribute :product_version
    attribute :client_product_version
    attribute :sp_client_product_version
    attribute :commerce_version

    attribute :cluster_type
    attribute :server_type

    attribute :env
    attribute :constants

    attribute :server_id
    attribute :server_guid
    attribute :cluster_server_id

    attribute :port_prefix
    attribute :sso_auth_enabled
    attribute :note

    attribute :ssl
    attribute :has_mlk
    attribute :has_logged_in
    attribute :default_admin_password
    attribute :query_limited
    attribute :stats_enabled
    attribute :secure_keystore_locked
    attribute :http_port
    attribute :https_port
    attribute :locale
  end
end
