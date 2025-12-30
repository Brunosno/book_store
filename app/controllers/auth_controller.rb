class AuthController < ApplicationController
    skip_before_action :authenticate_request, only: [:login, :register]

    def login
        user = AuthService.new.authenticate(auth_params[:username], auth_params[:password])
        if user
          render json: user, status: :ok
        else
          render json: { error: 'Credenciais inválidas' }, status: :unauthorized
        end
    end

    def register
        user = AuthService.new.register_user(auth_params)
        if user
            render json: user, status: :created
        else
            render json: { error: 'Erro ao registrar usuário' }, status: :unprocessable_entity
        end
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
