module Crashplan
  class Diagnostic < Resource
    attribute :timestamp, :from => 'diagnosticTimestamp', :as => DateTime
    attribute :db_ok
    attribute :volumes
    attribute :system_alerts
  end
end
