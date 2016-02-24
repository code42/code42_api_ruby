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
