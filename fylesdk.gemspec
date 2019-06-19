Gem::Specification.new do |gem|
    gem.name = %q{fylesdk}
    gem.version = "0.1.0"
    gem.date = %q{2019-06-11}
    gem.summary = %q{fylesdk is a gem to integrate Fyle data in applications}
    gem.files = [
      "lib/fylesdk.rb",
      "lib/exceptions.rb",
      "lib/fylesdk/api_base.rb",
      "lib/fylesdk/employees.rb",
      "lib/fylesdk/expenses.rb",
      "lib/fylesdk/reports.rb",
      "lib/fylesdk/advances.rb",
      "lib/fylesdk/trip_requests.rb",
      "lib/fylesdk/reimbursements.rb",
      "lib/fylesdk/settlements.rb"
    ]
    gem.author = "Shwetabh Kumar"
    gem.email = "shwetabh.kumar@fyle.in"
    gem.homepage = "https://github.com/fylein/fyle-sdk-ruby"
    gem.license = "MIT"
    gem.require_paths = ["lib"]
end