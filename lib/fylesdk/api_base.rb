module FyleSDK
    class ApiBase
        def initialize()
            @access_token = nil
            @base_url = nil
        end

        def change_access_token(access_token)
            @access_token = access_token
        end

        def set_base_url(base_url)
            @base_url = base_url
        end

        def get_request(path, params={})

            api_params = {}

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