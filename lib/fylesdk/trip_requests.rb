GET_TRIP_REQUESTS = '/api/tpa/v1/trip_requests'
GET_TRIP_REQUESTS_COUNT = '/api/tpa/v1/trip_requests/count'

module FyleSDK
    class TripRequests < ApiBase
        """Class for Trip Requests APIs."""
      
        def get(updated_at:nil, offset:nil, limit:nil, exported:nil)
            """Get a list of existing Trip Request matching the parameters.
    
            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                offset (int): A cursor for use in pagination, offset is an object ID that defines your place in the list. (optional)
                limit (int): A limit on the number of objects to be returned, between 1 and 1000. (optional)
    
            Returns:
                List with hashes in TripRequests schema.
            """
            params = {
                "updated_at" => updated_at,
                "offset" => offset,
                "limit" => limit
            }
            return self.get_request(GET_TRIP_REQUESTS, params)
        end
    
        def count(updated_at:nil, exported:nil)
            """Get the count of existing Trip Requests.
    
            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
    
            Returns:
                Count of Trip Request.
            """
            params = {
                "updated_at" => updated_at
            }
            return self.get_request(GET_TRIP_REQUESTS_COUNT, params)
        end
    end
end