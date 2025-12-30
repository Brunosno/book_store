class AddressesController < ApplicationController
  def index
    render json: Address.all, status: :ok
  end

  def show
    render json: Address.find(params[:id]), status: :ok
  end

  def create
    address = Address.new(address_params)
    if address.save
      render json: address, status: :created
    else
      render json: address.errors, status: :unprocessable_entity
    end
  end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      render json: address, status: :ok
    else
      render json: address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy!
    head :no_content
  end

  private
  def address_params
    params.require(:address).permit(:street, :city, :state, :cep, :person_id)
  end
end
