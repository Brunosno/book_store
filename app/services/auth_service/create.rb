module AuthService
    class Create < ApplicationService
        def initialize(params)
            @params = params
        end

        def call
            register_user(@params)
        end

        private

        def register_user(params)
            user = @user_model.new(params)

            if user.save
                return {id: user.id, username: user.username, is_admin: user.is_admin}
            else
                raise ActiveRecord::RecordInvalid.new(user)
            end
        end
    end
end