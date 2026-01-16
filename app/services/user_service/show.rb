module UserService
  class Show < ApplicationService
    def initialize(user_id)
      @user_id = user_id
    end

    def call
      find_user_by_id(@user_id)
    end

    private

    def find_user_by_id(user_id)
      user = User.find_by(id: user_id)

      if user
        convert_to_dto(user)
      else
        raise ActiveRecord::RecordNotFound, "User with id #{user_id} not found"
      end
    end

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
end