class AuthService
  def initialize(user_model = User)
    @user_model = user_model
  end

  def authenticate(username, password)
    user = @user_model.find_by(username: username)
        if user&.authenticate(password)
            token = JsonWebTokenService.encode({user_id: user.id, is_admin: user.is_admin})
            return {id: user.id, username: user.username, is_admin: user.is_admin, token: token}
        else
            return { error: 'Invalid username or password' }
        end
  end

  def register_user(params)
    user = @user_model.new(params)

    if user.save
      return {id: user.id, username: user.username, is_admin: user.is_admin}
    else
      raise ActiveRecord::RecordInvalid.new(user)
    end
  end
end