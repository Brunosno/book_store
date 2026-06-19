module AuthService
  class Authenticate < ApplicationService
    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      authenticate(@email, @password)
    end

    private

    def authenticate(email, password)
      user = User.find_by(email: email)

      if user&.authenticate(password)
          token = JsonWebTokenService.encode({user_id: user.id, is_admin: user.is_admin})
          return {id: user.id, username: user.username, is_admin: user.is_admin, token: token}
      else
          raise BusinessError, "Invalid email or password"
      end
    end
  end
end