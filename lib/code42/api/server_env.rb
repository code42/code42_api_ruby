module Code42
  module API
    module ServerEnv
      def server_env(params = {})
        object_from_response(Code42::ServerEnv, :get, 'ServerEnv', params)
      end
    end
  end
end
