class UsersController < ApplicationController
  def index
    users = UserService.new.find_all_users

    if users.any?
      render json: users, status: :ok
    else
      render json: { error: 'Nenhum registro encontrado' }, status: :not_found
    end
  end

  def show
    user = UserService.new.find_user_by_id(params[:id])
    if user
      render json: user, status: :ok
    else
      render json: { error: 'Registro não encontrado' }, status: :not_found
    end
  end

  def create
    user = UserService.new.create_user(user_params)
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
    render json: UserService.new.delete_user(params[:id])
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
        :cep 
      ],
      phone: [
        :ddd, 
        :number
      ]
    )
  end
end

