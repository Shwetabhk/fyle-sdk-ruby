GET_ADVANCES = '/api/tpa/v1/advances'
GET_ADVANCES_COUNT = '/api/tpa/v1/advances/count'

module FyleSDK
    class Advances < ApiBase
        """Class for Advances APIs."""
    
        def get(updated_at:nil, settled_at:nil, offset:nil, limit:nil, exported:nil)
            """Get a list of existing Advances.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                offset (int): A cursor for use in pagination, offset is an object ID that defines your place in the list. (optional)
                limit (int): A limit on the number of objects to be returned, between 1 and 1000. (optional)
                exported (bool): If set to true, all Advances that are exported alone will be returned. (optional)
                settled_at(str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)

            Returns:
                List with hashes in Advance schema.
            """
            params = {
                "updated_at" => updated_at,
                "offset" => offset,
                "limit" => limit,
                "settled_at" => settled_at,
                "exported" => exported
            }
            return self.get_request(GET_ADVANCES, params)
        end

        def count(updated_at:nil, exported:nil)
            """Get a count of the existing Advances that match the parameters.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                offset (int): A cursor for use in pagination, offset is an object ID that defines your place in the list. (optional)
                exported (bool): If set to true, all Advances that are exported alone will be returned. (optional)

            Returns:
                Count of Advances.
            """
            params = {
                "updated_at" => updated_at,
                "exported" => exported
            }
            return self.get_request(GET_ADVANCES_COUNT, params)
        end
    end
end
