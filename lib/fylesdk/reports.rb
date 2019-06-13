GET_REPORTS = '/api/tpa/v1/reports'
GET_REPORTS_COUNT = '/api/tpa/v1/reports/count'

module FyleSDK
    class Reports < ApiBase
        """Class for Reports APIs."""
    
        def get(updated_at:nil, settled_at:nil, reimbursed_at:nil, approved_at:nil, state:nil, offset:nil, limit:nil, exported:nil)
            """Get a list of Reports.
            
            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                offset (int): A cursor for use in pagination, offset is an object ID that defines your place in the list. (optional)
                limit (int): A limit on the number of objects to be returned, between 1 and 1000. (optional)
                exported (bool): If set to true, all Reports that are already submitted will alone be returned. (optional)
                settled_at(str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                approved_at(str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                reimbursed_at(str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                state(str): A parameter to filter reports by the state that they're in. (optional)

            Returns:
                List with hashes in Reports schema.
            """
            params = {
                "updated_at" => updated_at,
                "offset" => offset,
                "limit" => limit,
                "settled_at" => settled_at,
                "reimbursed_at" => reimbursed_at,
                "approved_at" => approved_at,
                "exported" => exported
            }
            return self.get_request(GET_REPORTS, params)
        end

        def count(updated_at:nil, exported:nil)
            """Get the count of Reports that match the parameters.
            
            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                exported (bool): If set to true, all Reports that are already submitted will alone be returned. (optional)

            Returns:
                Count of Reports.
            """
            params = {
                "updated_at" => updated_at,
                "exported" => exported
            }
            return self.get_request(GET_REPORTS_COUNT, params)
        end
    end
end