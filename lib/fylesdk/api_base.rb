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
                    api_params[key] = value
                end
            end

            url = URI.parse(@base_url + path)
            url.query = URI.encode_www_form(api_params)

            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            request = Net::HTTP::Get.new(url)
            request["Authorization"] = 'Bearer %s' % @access_token
            response = http.request(request)
            
            if response.code == "200"
                return JSON.parse(response.body)
    
            elsif response.code == "400"
                raise FyleSDK::WrongParamsError('Some of the parameters are wrong', JSON.parse(response.body))
    
            elif response.code == "401"
                raise FyleSDK::InvalidTokenError('Invalid token, try to refresh it', JSON.parse(response.body))
    
            elsif response.code == "403"
                raise FyleSDK::NoPrivilegeError('Forbidden, the user has insufficient privilege', JSON.parse(response.body))
    
            elsif response.code == "404"
                raise FyleSDK::NotFoundItemError('Not found item with ID', JSON.parse(response.body))
    
            elsif response.code == "498"
                raise FyleSDK::ExpiredTokenError('Expired token, try to refresh it', JSON.parse(response.body))
    
            elsif response.code == "500"
                raise FyleSDK::InternalServerError('Internal server error', JSON.parse(response.body))
    
            else
                raise FyleSDK::FyleSDKError('Error: %s' % response.code, JSON.parse(response.body))
            end
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
            request["Authorization"] = 'Bearer %s' % @access_token
            request.body = body.to_json()
            response = http.request(request)

            if response.code == "200"
                return JSON.parse(response.body)
    
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