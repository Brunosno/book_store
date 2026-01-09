class UserService
  def initialize(user_model = User)
    @user_model = user_model
  end

  def find_all_users
    @user_model.all.map { |user| convert_to_dto_response(user) }
  end

  def find_user_by_id(user_id)
    user = @user_model.find_by(id: user_id)
    if user
      convert_to_dto_response(user)
    else
      raise ActiveRecord::RecordNotFound, "User with id #{user_id} not found"
    end
  end

  def create_user(params)
    user = @user_model.new(convert_to_dto(params))

    if user.save

      if params[:phone].present?
        phone = PhoneService.new.create_phone(params[:phone], user[:id])

        if phone[:error]
          raise phone[:error]
        end
      end

      if params[:addresses].present?
        address = AddressService.new.create_address(params[:addresses], user[:id])
      
        if address[:error]
          raise address[:error]
        end
      end

      convert_to_dto_response(user)
    else
      raise ActiveRecord::RecordInvalid.new(user)
    end
  end

  def update_user(user_id, params)
    user = @user_model.find_by(id: user_id)
    if user.update(convert_to_dto(params))
      convert_to_dto_response(user)
    else
      raise ActiveRecord::RecordInvalid.new(user)
    end
  end

  def delete_user(user_id)
    user = @user_model.find_by(id: user_id)
    if !user
      raise ActiveRecord::RecordNotFound, "User not found"
    end
    
    if user.destroy
      { message: "User deleted successfully" }
    else
      raise StandardError, "Failed to delete user"
    end
  end

  def find_user_by_username(username)
    user = @user_model.find_by(username: username)
    if user
      convert_to_dto_response(user)
    else
      raise ActiveRecord::RecordNotFound, "User with username #{username} not found"
    end
  end

  private

  def convert_to_dto(user)
    {
      name: user[:name],
      email: user[:email],
      username: user[:username],
      password: user[:password],
      is_admin: user[:is_admin]
  }.compact
  end

  def convert_to_dto_response(user)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      username: user.username,
      is_admin: user.is_admin
    }
  end
end