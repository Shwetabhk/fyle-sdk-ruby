module FyleSDK
    class ApiBase
        """The base class for all API classes."""
        
        def initialize()
            @access_token = nil
            @base_url = nil
        end

        def change_access_token(access_token)
            """Change the old access token with the new one.
            
            Parameters:
                access_token (str): The new access token.
            """
            @access_token = access_token
        end

        def set_base_url(base_url)
            """Set the server URL dynamically upon creating a connction

            Parameters:
                base_url(str): The current server URL
            """
            @base_url = base_url
        end

        def get_request(path, params={})
            """Create a HTTP GET request.

            Parameters:
                params (hash): HTTP GET parameters for the wanted API.
                path (str): Url for the wanted API.

            Returns:
                A response from the request (hash).
            """

            api_params = {}

            # ignore all unused params
            params.each do |key, value|
                if value != nil
                    puts key
                    puts value
                    api_params[key] = value
                end
            end

            url = URI.parse(@base_url + path)
            url.query = URI.encode_www_form(api_params)

            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            request = Net::HTTP::Get.new(url)
            request["X-AUTH-TOKEN"] = @access_token
            response = http.request(request)
            return JSON.parse(response.body)
        end

        def post_request(path, body)
            """Create a HTTP post request.

            Parameters:
                body (hash): HTTP POST body data for the wanted API.
                path (str): Url for the wanted API.

            Returns:
                A response from the request (dict).
            """
            url = URI.parse(@base_url + path)
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true

            request = Net::HTTP::Post.new(url)
            request["Content-Type"] = 'application/json'
            request["X-Auth-Token"] = @access_token
            request.body = body.to_json()
            response = http.request(request)
            return JSON.parse(response.body)
        end
    end
end