require 'jwt'

module Auth
  class JwtTokenAuth
    ALGORITHM = 'HS256'
    DEFAULT_EXPIRE_TIME = (Time.now + 2.weeks).to_i

    def self.issue_token(payload, exp: DEFAULT_EXPIRE_TIME)
      JWT.encode payload, auth_secret, ALGORITHM
    end

    def self.decode_token(token)
      JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
    end

    def self.auth_secret
      Rails.application.secrets.secret_key_base || ENV['SECRET_KEY_BASE']
    end
  end
end
