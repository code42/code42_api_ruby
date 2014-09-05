module Code42
  class Destination < Resource

    attribute :destination_id
    attribute :computer_id
    attribute :guid
    attribute :destination_name
    attribute :type

    attribute :accepting_inbound_backup
    attribute :accepting_new_computers
    attribute :server_online_status

    attribute :cluster_server_id

    attribute :org_count
    attribute :user_count
    attribute :computer_count
    attribute :online_computer_count

    attribute :used_bytes

    attribute :archive_bytes

    attribute :backup_session_count
    attribute :inbound_bandwidth
    attribute :outbound_bandwidth
    attribute :selected_bytes
    attribute :remaining_bytes

    attribute :destination_name
    attribute :original_destination_name

    attribute :balancing_data
    attribute :balanced_store_point_count

    attribute :server_count
    attribute :offline_server_count
    attribute :store_point_count

    attribute :total_bytes
    attribute :used_percentage
    attribute :free_bytes
    attribute :free_percentage

    attribute :cold_bytes
    attribute :cold_percentage_of_used
    attribute :cold_percentage_of_total

    attribute :settings
  end
end
