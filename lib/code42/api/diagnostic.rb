module Code42
  module API
    module Diagnostic
      def diagnostic
        object_from_response(Code42::Diagnostic, :get, 'diagnostic')
      end
    end
  end
end