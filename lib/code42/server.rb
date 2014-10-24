module Code42
  class Server < Resource
    attribute :id, from: 'serverId'

    attribute :guid
    attribute :name, from: 'serverName'
    attribute :type
    attribute :version

    attribute :online
    attribute :out_of_date
    attribute :accepting_inbound_backup
    attribute :balancing_data
    attribute :accepting_new_computers
    attribute :db_empty

    attribute :cluster_server_id
    attribute :destination_id
    attribute :destination_name
    attribute :provider_destination_name
    attribute :primary_address
    attribute :secondary_address
    attribute :website_host
    attribute :store_point_count

    attribute :total_bytes
    attribute :used_bytes
    attribute :used_percentage
    attribute :free_bytes
    attribute :free_percentage
    attribute :cold_bytes
    attribute :cold_percentage_of_used
    attribute :cold_percentage_of_total

    attribute :archive_bytes
    attribute :selected_bytes
    attribute :remaining_bytes

    attribute :inbound_bandwidth
    attribute :outbound_bandwidth
    attribute :org_count
    attribute :user_count
    attribute :licensed_user_count
    attribute :computer_count
    attribute :backup_computer_count
    attribute :online_computer_count

    attribute :backup_session_count

    def connection_string
      client.server_connection_string(id)
    end
  end
end
