module UserService
  class Update < ApplicationService
    def initialize(user_id, params)
      @user_id = user_id
      @params = params
    end

    def call
      update_user(@user_id, @params)
    end

    private

    def update_user(user_id, params)
      user = User.find_by(id: user_id)

      if user
        user.update(convert_to_dto(params))
        convert_to_response_dto(user)
      else
        raise ActiveRecord::RecordNotFound, "User with id #{user_id} not found"
      end
    end

    def convert_to_dto(user)
      {
        name: user[:name],
        email: user[:email],
        username: user[:username],
        password: user[:password],
        is_admin: user[:is_admin]
      }.compact
    end

    def convert_to_response_dto(user)
      {
        id: user.id,
        name: user.name,
        email: user.email
        username: user.username,
        is_admin: user.is_admin,
      }
    end
  end
end