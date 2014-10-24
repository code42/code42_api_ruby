module Code42
  class StorePoint < Resource

    attribute :id, :from => 'storePointId'
    attribute :name, :from => 'storePointName'
    attribute :note
    attribute :path
    attribute :directory
    attribute :absolute_path
    attribute :server_id
    attribute :server_name
    attribute :destination_id
    attribute :destination_name
    attribute :backup_session_count
    attribute :computer_count
    attribute :backup_computer_count
    attribute :user_count
    attribute :licensed_user_count
    attribute :org_count
    attribute :used_bytes
    attribute :used_percentage
    attribute :free_bytes
    attribute :free_bytes_alert
    attribute :free_percentage
    attribute :cold_bytes
    attribute :cold_percentage_of_used
    attribute :cold_percentage_of_total
    attribute :total_bytes
    attribute :accepting_inbound_backup
    attribute :balancing_data
    attribute :accepting_new_computers
    attribute :write_speed
    attribute :online
    attribute :server_online
    attribute :archive_bytes
    attribute :selected_bytes
    attribute :todo_bytes

    def enable_balancing
      client.update_store_point id, balancing_data: true
    end

    def disable_balancing
      client.update_store_point id, balancing_data: false
    end

    def enable_inbound_backup
      client.update_store_point id, accepting_inbound_backup: true
    end

    def disable_inbound_backup
      client.update_store_point id, accepting_inbound_backup: false
    end

    def accept_new_devices
      client.update_store_point id, accepting_new_computers: true
    end

    def reject_new_devices
      client.update_store_point id, accepting_new_computers: false
    end
  end
end
