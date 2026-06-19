module Api
  module V1
    class AuthController < ApiController
      skip_before_action :authenticate_request, only: [:login, :register]

      def login
        result = AuthService::Authenticate.call(auth_params[:email], auth_params[:password])

        render_success(
          data: result,
          message: "Login realizado com sucesso"
        )
      end

      def register
        result = AuthService::Create.call(auth_params)

        render_success(
          data: result,
          message: "Usuário registrado com sucesso",
          status: :created
        )
      end

      private

      def auth_params
          params.require(:auth).permit(
              :name,
              :email,
              :username,
              :password
          )
      end
    end
  end
end
