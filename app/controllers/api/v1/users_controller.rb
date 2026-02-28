module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_request, only: [:create]
      before_action :authorize_admin!, only: [:index, :destroy]
      before_action :set_user, only: [:show, :update]

      def index
        per_page = [params[:per_page].to_i, 50].min
        per_page = 10 if per_page <= 0

        users = User.page(params[:page]).per(per_page)

        render_success(
          data: users.map { |user| convert_to_dto(user) },
          message: "Users retrieved successfully",
          meta: pagination_meta(users)
        )
      end

      def show
        render_success(
          data: convert_to_dto(@user),
          message: "User retrieved successfully"
        )
      end

      def create
        user = UserService::Create.call(user_params_without_admin)

        render_success(
          data: convert_to_dto(user),
          message: "User created successfully",
          status: :created
        )
      end

      def update
        user = UserService::Update.call(@user.id, user_params_without_admin)

        render_success(
          data: convert_to_dto(user),
          message: "User updated successfully"
        )
      end

      def destroy
        User.find(params[:id]).destroy!

        head :no_content
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(
          :name,
          :email,
          :username,
          :password,
          :is_admin,
          addresses: [:street, :city, :state, :zip_code],
          phone: [:ddd, :number]
        )
      end

      def user_params_without_admin
        user_params.except(:is_admin)
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

      def pagination_meta(collection)
        {
          current_page: collection.current_page,
          next_page: collection.next_page,
          prev_page: collection.prev_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count
        }
      end
    end
  end
end