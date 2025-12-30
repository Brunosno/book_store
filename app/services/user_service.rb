class UserService
  def initialize(user_model = User)
    @user_model = user_model
  end

  def find_all_users
    return @user_model.all
  end

  def find_user_by_id(user_id)
    user = @user_model.find_by(id: user_id)
    if user
      return convert_to_dto(user)
    else
      raise ActiveRecord::RecordNotFound, "User with id #{user_id} not found"
    end
  end

  def create_user(params)
    user = @user_model.new(params)

    if user.save
      return convert_to_dto(user)
    else
      raise ActiveRecord::RecordInvalid.new(user)
    end
  end

  def update_user(user_id, params)
    user = @user_model.find_by(id: user_id)
    if user.update(params)
      return convert_to_dto(user)
    else
      raise ActiveRecord::RecordInvalid.new(user)
    end
  end

  def delete_user(user_id)
    user = @user_model.find_by(id: user_id)
    user.destroy
  end

  def find_user_by_username(username)
    user = @user_model.find_by(username: username)
    if user
      return convert_to_dto(user)
    else
      raise ActiveRecord::RecordNotFound, "User with username #{username} not found"
    end
  end

  private

  def convert_to_dto(user)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      username: user.username,
      is_admin: user.is_admin
    }
  end
end