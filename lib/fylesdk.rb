require 'net/http'
require 'json'

require_relative 'fylesdk/api_base'
require_relative 'fylesdk/employees'
require_relative 'fylesdk/expenses'
require_relative 'fylesdk/reports'
require_relative 'fylesdk/advances'
require_relative 'fylesdk/trip_requests'

require_relative './exceptions'

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
        @expenses = FyleSDK::Expenses.new()
        @reports = FyleSDK::Reports.new()
        @advances = FyleSDK::Advances.new()
        @trip_requests = FyleSDK::TripRequests.new()

        # get the access token and base_url
        self.update_access_token
        self.update_base_url
      end

      """Make callable functions for each API Object"""
      def employees
        return @employees
      end

      def expenses
        return @expenses
      end

      def reports
        return @reports
      end
      
      def advances
        return @advances
      end

      def trip_requests
        return @trip_requests
      end

      """Functions to set information in APIs"""

      def update_access_token
        """Update the access token and change it in all API objects."""

        @employees.change_access_token(@access_token)
        @expenses.change_access_token(@access_token)
        @reports.change_access_token(@access_token)
        @advances.change_access_token(@access_token)
        @trip_requests.change_access_token(@access_token)
      end

      def update_base_url
        """Update the base_url and change it in all API objects."""

        @employees.set_base_url(@base_url)
        @expenses.set_base_url(@base_url)
        @reports.set_base_url(@base_url)
        @advances.set_base_url(@base_url)
        @trip_requests.set_base_url(@base_url)
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

        if response.code == "200"
          data = JSON.parse(response.body)
          return data["access_token"]
        elsif response.code == "400"
            raise FyleSDK::WrongParamsError.new('Some of the parameters are wrong', JSON.parse(response.body))

        elif response.code == "401"
            raise FyleSDK::InvalidTokenError.new('Invalid token, try to refresh it', JSON.parse(response.body))

        elsif response.code == "403"
            raise FyleSDK::NoPrivilegeError.new('Forbidden, the user has insufficient privilege', JSON.parse(response.body))

        elsif response.code == "404"
            raise FyleSDK::NotFoundItemError.new('Not found item with ID', JSON.parse(response.body))

        elsif response.code == "498"
            raise FyleSDK::ExpiredTokenError.new('Expired token, try to refresh it', JSON.parse(response.body))

        elsif response.code == "500"
            raise FyleSDK::InternalServerError.new('Internal server error', JSON.parse(response.body))

        else
            raise FyleSDK::FyleSDKError.new('Error: %s' % response.code, JSON.parse(response.body))
        end
      end
    end
end