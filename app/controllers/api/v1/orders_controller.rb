module Api
  module V1
    class OrdersController < ApiController
      before_action :authorize_admin!, only: [:index, :show, :update]

      def index
        per_page = [params[:per_page].to_i, 50].min
        per_page = 10 if per_page <= 0

        orders = Order
                   .includes(:user, :address, :order_items)
                   .page(params[:page])
                   .per(per_page)

        render_success(
          data: orders,
          message: "Orders retrieved successfully",
          meta: pagination_meta(orders)
        )
      end

      def show
        order = Order
                  .includes(:user, :address, :order_items)
                  .find(params[:id])

        render_success(
          data: order,
          message: "Order retrieved successfully"
        )
      end

      def create
        order = OrderService::Create.call(order_params, current_user.id)

        render_success(
          data: order,
          message: "Order created successfully",
          status: :created
        )
      end

      def update
        order = OrderService::Update.call(params[:id], order_params)

        render_success(
          data: order,
          message: "Order updated successfully"
        )
      end

      def destroy
        OrderService.new.delete_order(params[:id])

        head :no_content
      end

      private

      def order_params
        params.require(:order).permit(
          :address_id,
          order_items_attributes: [
            :book_id,
            :quantity
          ]
        )
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