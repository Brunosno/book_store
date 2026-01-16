module Api
  module V1
    class AddressesController < ApiController
      skip_before_action :authenticate_request, only: [:index, :show, :create]

      def index
        render json: Address.all, status: :ok
      end

      def show
        render json: AddressService::Show.call(params[:id]), status: :ok
      end

      def create
        address = AddressService::Create.call(address_params)
        if address
          render json: address, status: :created
        else
          render json: address.errors, status: :unprocessable_entity
        end
      end

      def update
        address = AddressService::Update.call(params[:id], address_params)
        if address
          render json: address, status: :created
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
        params.require(:address).permit(:street, :city, :state, :zip_code, :person_id)
      end
    end
  end
end