GET_SETTLEMENTS = '/api/tpa/v1/settlements'
GET_SETTLEMENT_BY_ID = '/api/tpa/v1/settlements/%s'
GET_SETTLEMENTS_COUNT = '/api/tpa/v1/settlements/count'

 module FyleSDK
    class Settlements < ApiBase
        """Class for Settlements APIs."""
    
        def get(updated_at: nil, offset: nil, limit: nil)
            """Get Settlements that satisfy the parameters.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                offset (int): A cursor for use in pagination, offset is an object ID that defines your place in the list. (optional)
                limit (int): A limit on the number of objects to be returned, between 1 and 1000. (optional)

            Returns:
                List with hashes in Settlements schema.
            """
            params = {
                'updated_at' => updated_at,
                'offset' => offset,
                'limit' => limit
            }
            return self.get_request(GET_SETTLEMENTS, params)
        end

        def get_by_id(settlement_id)
            """Get an Settlement by Id.

            Parameters:
                settlement_id (str): Unique ID to find an Settlement. Settlement Id is our internal Id, it starts with prefix re always. (required)

            Returns:
                Hash in Settlement schema.
            """
            return self.get_request(GET_SETTLEMENT_BY_ID % settlement_id)
        end

        def count(updated_at: nil)
            """Get the number of Settlements that satisfy the parameters.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                exported (bool): If set to true, all Settlements that are exported alone will be returned. (optional)

            Returns:
                Count of Settlements.
            """
            params = {
                'updated_at' => updated_at
            }
            return self.get_request(GET_SETTLEMENTS_COUNT, params)
        end
    end
end