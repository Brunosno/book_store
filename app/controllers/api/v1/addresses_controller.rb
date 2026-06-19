module Api
  module V1
    class AddressesController < ApiController
      before_action :authorize_admin!, only: [:index, :show, :destroy]

      def index
        per_page = [params[:per_page].to_i, 50].min
        per_page = 10 if per_page <= 0

        addresses = Address.page(params[:page]).per(per_page)

        render_success(
          data: addresses,
          message: "Addresses retrieved successfully",
          meta: {
            current_page: addresses.current_page,
            next_page: addresses.next_page,
            prev_page: addresses.prev_page,
            total_pages: addresses.total_pages,
            total_count: addresses.total_count
          }
        )
      end

      def show
        address = Address.find(params[:id])

        render_success(
          data: address,
          message: "Address retrieved successfully"
        )
      end

      def create
        address = AddressService::Create.call(address_params, current_user.id)

        render_success(
          data: address,
          message: "Address created successfully",
          status: :created
        )
      end

      def update
        address = AddressService::Update.call(params[:id], address_params)

        render_success(
          data: address,
          message: "Address updated successfully"
        )
      end

      def destroy
        Address.find(params[:id]).destroy!

        head :no_content
      end

      def my_addresses
      per_page = [params[:per_page].to_i, 50].min
      per_page = 10 if per_page <= 0

      addresses = Address
                    .where(person_id: current_user.id)
                    .page(params[:page])
                    .per(per_page)

      render_success(
        data: addresses,
        message: "User addresses retrieved successfully",
        meta: {
          current_page: addresses.current_page,
          next_page: addresses.next_page,
          prev_page: addresses.prev_page,
          total_pages: addresses.total_pages,
          total_count: addresses.total_count
        }
      )
    end

      private

      def address_params
        params.require(:address)
              .permit(:street, :city, :state, :zip_code, :nickname)
      end
    end
  end
end