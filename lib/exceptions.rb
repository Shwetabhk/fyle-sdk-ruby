module FyleSDK
    class FyleSDKError < StandardError
        attr_reader :response
        def initialize(message, response={"error" => "This is an error"})
            @message = message
            @response = response
            super(message)
        end
    end

    class NotFoundClientError < FyleSDKError
        """Client not found OAuth2 authorization, 404 error."""
    end


    class UnauthorizedClientError < FyleSDKError
        """Wrong client secret and/or refresh token, 401 error."""
    end


    class ExpiredTokenError < FyleSDKError
        """Expired (old) access token, 498 error."""
    end


    class InvalidTokenError< FyleSDKError
        """Wrong/non-existing access token, 401 error."""
    end


    class NoPrivilegeError < FyleSDKError
        """The user has insufficient privilege, 403 error."""
    end


    class WrongParamsError < FyleSDKError
        """Some of the parameters (HTTP params or request body) are wrong, 400 error."""
    end


    class NotFoundItemError < FyleSDKError
        """Not found the item from URL, 404 error."""
    end
        

    class InternalServerError < FyleSDKError
        """The rest FyleSDK errors, 500 error."""
    end
end