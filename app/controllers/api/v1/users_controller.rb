module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_request, only: [:index, :show, :create, :update, :destroy]

      def index
        users = User.all.map { | user | convert_to_dto(user) }

        if users.any?
          render json: users, status: :ok
        else
          raise ActiveRecord::RecordNotFound, 'No users found', status: :not_found
        end
      end

      def show
        user = UserService::Show.call(params[:id])
        if user
          render json: user, status: :ok
        else
          raise ActiveRecord::RecordNotFound, 'User not found', status: :not_found
        end
      end

      def create
        user = UserService::Create.call(user_params)
        if user
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def update
        user = UserService.new.update_user(params[:id], user_params)
        if user
          render json: user, status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find_by(id: params[:id])
        user.destroy!
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(
          :name,
          :email,
          :username,
          :password,
          :is_admin,
          addresses: [
            :street,
            :city,
            :state,
            :zip_code
          ],
          phone: [
            :ddd,
            :number
          ]
        )
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
end