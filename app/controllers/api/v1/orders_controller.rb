module Api
  module V1
    class OrdersController < ApiController
      skip_before_action :authenticate_request, only: [:index, :show, :create, :update, :destroy]

      def index
        orders = OrderService.new.find_all_orders(
          page: params[:page],
          per_page: params[:per] || 10
        )

        render json: orders, status: :ok
      end

      def show
        order = OrderService.new.find_order_by_id(params[:id])
        render json: order, status: :ok
      end

      def create
        order = OrderService::Create.call(order_params)
        render json: order, status: :created
      end

      def update
        order = OrderService.new.update_order(params[:id], order_params)
        render json: order, status: :ok
      end

      def destroy
        order = OrderService.new.delete_order(params[:id])
        render json: order, status: :ok
      end

      private

      def order_params
        params.require(:order).permit(
          :user_id,
          :address_id,
          order_items_attributes: [
            :book_id,
            :quantity
          ]
        )
      end
    end
  end
end
