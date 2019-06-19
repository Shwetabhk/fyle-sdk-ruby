GET_REIMBURSEMENTS = '/api/tpa/v1/reimbursements'
GET_REIMBURSEMENT_BY_ID = '/api/tpa/v1/reimbursements/%s'
GET_REIMBURSEMENTS_COUNT = '/api/tpa/v1/reimbursements/count'

module FyleSDK
    class Reimbursements < ApiBase 
        """Class for Reimbursements APIs."""
    
        def get(updated_at: nil, offset: nil, limit: nil, exported: nil)
            """Get Reimbursments that satisfy the parameters.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                offset (int): A cursor for use in pagination, offset is an object ID that defines your place in the list. (optional)
                limit (int): A limit on the number of objects to be returned, between 1 and 1000. (optional)
                exported (bool): If set to true, all Reimbursments that are exported alone will be returned. (optional)

            Returns:
                List with hashes in Reimbursments schema.
            """
            params = {
                'updated_at' => updated_at,
                'offset' => offset,
                'limit' => limit,
                'exported' => exported
            }
            return self.get_request(GET_REIMBURSEMENTS, params)
        end

        def get_by_id(reimbursement_id)
            """Get an Reimbursement by Id.

            Parameters:
                reimbursement_id (str): Unique ID to find an Reimbursement. Reimbursement Id is our internal Id, it starts with prefix re always. (required)

            Returns:
                Hash in Reimbursement schema.
            """
            return self.get_request(GET_REIMBURSEMENT_BY_ID % reimbursement_id)
        end

        def count(updated_at:nil, exported:nil)
            """Get the number of Reimbursements that satisfy the parameters.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                exported (bool): If set to true, all Reimbursements that are exported alone will be returned. (optional)

            Returns:
                Count of Reimbursements.
            """
            params = {
                'updated_at' => updated_at,
                'exported' => exported
            }
            return self.get_request(GET_REIMBURSEMENTS_COUNT, params)
        end
    end
end