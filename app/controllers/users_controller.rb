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

      phone = PhoneService.new.create_phone(user_params[:phone], user.id)
      address = AddressService.new.create_address(user_params[:addresses], user.id)

      if phone && address
        user.phone << phone
        user.addresses << address
      else
        render json: { error: 'Erro ao salvar telefone ou endereço' }, status: :unprocessable_entity and return
      end
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = UserService.new.update_user(params[:id], params: user_params)
    if user
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    UserService.new.delete_user(params[:id])
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
        :cep
      ],
      phone: {
        :ddd, 
        :number
      }
    )
  end
end

