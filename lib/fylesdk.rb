require 'net/http'
require_relative 'fylesdk/employees'
require 'json'

module FyleSDK
    class Connect
      def initialize(base_url, client_id, client_secret, refresh_token)
        @base_url = base_url
        @client_id = client_id
        @client_secret = client_secret
        @refresh_token = refresh_token
        @access_token = self.get_access_token

        @employees = FyleSDK::Employees.new()

        self.update_access_token
        self.update_base_url
      end

      def employees
        return @employees
      end

      def update_access_token
        @employees.change_access_token(@access_token)
      end

      def update_base_url
        @employees.set_base_url(@base_url)
      end

      def get_access_token
        url = URI.parse(@base_url + "/api/auth/access_token")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        body = {
          'grant_type' => 'refresh_token',
          "client_id" => @client_id,
          "client_secret" => @client_secret,
          "refresh_token" => @refresh_token
        }
        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = 'application/json'
        request.body = body.to_json()
        response = http.request(request)
        data = JSON.parse(response.body)
        return data["access_token"]
      end
    end
end