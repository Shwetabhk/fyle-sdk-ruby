POST_EMPLOYEES = '/api/tpa/v1/employees'
GET_EMPLOYEES = '/api/tpa/v1/employees'
GET_EMPLOYEE_BY_ID = '/api/tpa/v1/employees/%s'
GET_EMPLOYEE_ADMIN = '/api/tpa/v1/employees/my_profile'
GET_EMPLOYEES_COUNT = '/api/tpa/v1/employees/count'

module FyleSDK
    class Employees < ApiBase
        def post(data)
            """Create or Update Employees in bulk.

            Parameters:
                data (list): List of hashes in Employees schema.
            
            Returns:
                List with IDs from the new Employees.
            """
            response = self.post_request(POST_EMPLOYEES, data)
            return response
        end

        def get(updated_at: nil, offset: nil, limit: nil)
            """Get a list of existing Employees matching the parameters.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)
                offset (int): A cursor for use in pagination, offset is an object ID that defines your place in the list. (optional)
                limit (int): A limit on the number of objects to be returned, between 1 and 1000. (optional)

            Returns:
                List with hashes in Employees schema.
            """
            params = {
                "updated_at" => updated_at,
                "offset" => offset,
                "limit" => limit
            }

            response = self.get_request(GET_EMPLOYEES, params)
            return response
        end

        def get_by_id(employee_id)
            '''Get a the details of the Employee by Id

            Parameters:
                employee_id (str): Unique ID to find an Employee. Employee Id is our internal Id, it starts with prefix ou always. (required)

            Returns:
                Hash in Employee schema.
            '''
            response = self.get_request(GET_EMPLOYEE_BY_ID % employee_id)
            return response
        end

        def get_my_profile
            '''Get a the Employee details of the admin

            Parameters:
                nil

            Returns:
                Hash in Employee schema.
            '''
            response = self.get_request(GET_EMPLOYEE_ADMIN)
            return response
        end

        def count(updated_at: nil)
            """Get the count of existing Employees.

            Parameters:
                updated_at (str): Date string in yyyy-MM-ddTHH:mm:ss.SSSZ format along with operator in RHS colon pattern. (optional)

            Returns:
                Count of Employees.
            """
            params = {
                updated_at: updated_at
            }
            response = self.get_request(GET_EMPLOYEES_COUNT, params)
        end
    end
end