class Token
  def self.gen(payload)
    JWT.encode payload, Rails.application.secrets.jwt_secret_key, 'HS256'
  end

  def self.decode(token)
    JWT.decode(
      token,
      Rails.application.secrets.jwt_secret_key,
      true,
      algorithm: 'HS256'
    )[0]
  end
end