# frozen_string_literal: true

module RequestHelper
  def authorize_user_by_token(user)
    headers = authorization_header(user)
    allow_any_instance_of(ActionDispatch::Request).to receive(:headers).and_return(headers)
  end

  def encode_payload(user)
    {
      sub: user.id,
      scp: "user",
      aud: "",
      iat: Time.current.to_i,
      exp: (Time.current + 1.hour).to_i,
      jti: "80f3eb15-5184-4463-95ec-d240ce199309"
    }
  end

  def authorization_header(user)
    token = JWT.encode(encode_payload(user), ENV["DEVISE_JWT_SECRET_KEY"])

    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{token}"
    }
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
  config.include RequestHelper, type: :controller
end
