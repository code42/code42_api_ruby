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
