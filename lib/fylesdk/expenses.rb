POST_EXPENSE = '/api/tpa/v1/expenses'
GET_EXPENSES = '/api/tpa/v1/expenses'
GET_EXPENSES_COUNT = '/api/tpa/v1/expenses/count'
GET_EXPENSE_BY_ID = '/api/tpa/v1/expenses/%s'
GET_EXPENSE_ATTACHMENTS = '/api/tpa/v1/expenses/%s/attachments'

module FyleSDK
    class Expenses < ApiBase
        """Class for Expenses APIs."""

        def post(data)
            """Create an Expense for an Employee.

            Parameters:
                data (Hash): Hash in Expense schema.
            
            Returns:
                ID from the new Expense.
            """
            return self.post_request(POST_EXPENSE, data)
        end
            
        def get(updated_at:nil, settled_at:nil, reimbursed_at:nil, approved_at:nil, state:nil, offset:nil, verified:nil, limit:nil, submitted:nil, fund_source:nil)
            """Get a list of existing Expenses, excluding the file attachments, that match the parameters.
            
            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                offset (int): A cursor for use in pagination, offset is an object ID that defines your place in the list. (optional)
                limit (int): A limit on the number of objects to be returned, between 1 and 1000. (optional)
                submitted (bool): If set to true, all Expenses that are already submitted will alone be returned. (optional)
                settled_at(str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                approved_at(str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                reimbursed_at(str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                state(str): A parameter to filter expenses by the state that they're in. (optional)
                verified(bool): A parameter to filter verified or unverified expenses. (optional)
                fund_source(str): A parameter to filter expenses by fund source. (optional)

            Returns:
                List with hashes in Expenses schema.
            """
            params = {
                "updated_at" => updated_at,
                "offset" => offset,
                "limit" => limit,
                "submitted" => submitted,
                "settled_at" => settled_at,
                "reimbursed_at" => reimbursed_at,
                "approved_at" => approved_at,
                "state" => state,
                "verified" => verified,
                "fund_source" => fund_source
            }
            return self.get_request(GET_EXPENSES, params)
        end

        def count(updated_at:nil, exported:nil, submitted:nil)
            """Get the count of existing Expenses that match the given parameters.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                exported (bool): If set to true, all Expenses that are exported alone will be returned. (optional)
                submitted (bool): If set to true, all Expenses that are already submitted will alone be returned. (optional)

            Returns:
                Count of Expenses.
            """
            params = {
                "updated_at" => updated_at,
                "exported" => exported,
                "submitted" => submitted
            }
            return self.get_request(GET_EXPENSES_COUNT, params)
        end

        def get_by_id(expense_id)
            """Get an Expense by Id including the file attachments.

            Parameters:
                expense_id (str): Unique ID to find an Expense. Expense Id is our internal Id, it starts with prefix tx always. (required)

            Returns:
                Hash in Expense schema.
            """
            return self.get_request(GET_EXPENSE_BY_ID % expense_id)
        end
        
        def get_attachments(expense_id)
            """Get all the file attachments associated with an Expense.

            Parameters:
                expense_id (str): Unique ID to find an Expense. Expense Id is our internal Id, it starts with preifx tx always. (required)

            Returns:
                List with hashes in Attachments schema.
            """
            return self.get_request(GET_EXPENSE_ATTACHMENTS % expense_id)
        end
    end
end