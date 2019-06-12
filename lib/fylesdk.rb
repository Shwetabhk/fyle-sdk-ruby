require 'net/http'
require_relative 'fylesdk/employees'
require 'json'

module FyleSDK
    class Connect
      """The main class which creates a connection with Fyle APIs using OAuth2 authentication (refresh token grant type).

      Parameters:
          base_url (str): Current Server URL
          client_id (str): Client ID for Fyle API.
          client_secret (str): Client secret for Fyle API.
          refresh_token (str): Refresh token for Fyle API.
      """
      def initialize(base_url, client_id, client_secret, refresh_token)
        @base_url = base_url
        @client_id = client_id
        @client_secret = client_secret
        @refresh_token = refresh_token
        @access_token = self.get_access_token

        # create an object for each api
        @employees = FyleSDK::Employees.new()

        # get the access token and base_url
        self.update_access_token
        self.update_base_url
      end

      """Make callable functions for each API Object"""
      def employees
        return @employees
      end

      def update_access_token
        """Update the access token and change it in all API objects."""

        @employees.change_access_token(@access_token)
      end

      def update_base_url
        """Update the base_url and change it in all API objects."""

        @employees.set_base_url(@base_url)
      end

      def get_access_token
        """Get the access token using a HTTP post.
        
        Returns:
            A new access token.
        """

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