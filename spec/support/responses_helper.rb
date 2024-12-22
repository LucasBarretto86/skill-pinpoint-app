# frozen_string_literal: true

module ResponsesHelper
  #  LUCAS: Just to make simpler to assert responses on tests
  def response_body
    raise "Only available for JSON requests" unless request.format.json?
    return "" unless response

    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include(ResponsesHelper, type: :request)
  config.include(ResponsesHelper, type: :controller)
end
