module ApiHelpers
  def json_response
    JSON.parse(response.body)
  end

  def json_response_struct
    JSON.parse(response.body, object_class: OpenStruct)
  end
end

RSpec.configure do |config|
  config.include ApiHelpers
end
