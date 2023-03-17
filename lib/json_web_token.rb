class JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base
  ALGORITHM = 'HS256'.freeze

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM }).first
  end
end
