require_relative './api_base'

POST_EMPLOYEES = '/api/tpa/v1/employees'
GET_EMPLOYEES = '/api/tpa/v1/employees'
GET_EMPLOYEE_BY_ID = '/api/tpa/v1/employees/%s'
GET_EMPLOYEE_ADMIN = '/api/tpa/v1/employees/my_profile'
GET_EMPLOYEES_COUNT = '/api/tpa/v1/employees/count'

module FyleSDK
    class Employees < ApiBase
        def post(data)
            response = self.post_request(POST_EMPLOYEES, data)
            return response
        end

        def get(updated_at: nil, offset: nil, limit: nil)
            params = {
                "updated_at" => updated_at,
                "offset" => offset,
                "limit" => limit
            }

            response = self.get_request(GET_EMPLOYEES, params)
            return response
        end

        def get_by_id(employee_id)
            response = self.get_request(GET_EMPLOYEE_BY_ID % employee_id)
            return response
        end

        def get_my_profile
            response = self.get_request(GET_EMPLOYEE_ADMIN)
            return response
        end

        def count(updated_at: nil)
            params = {
                updated_at: updated_at
            }
            response = self.get_request(GET_EMPLOYEES_COUNT, params)
        end
    end
end