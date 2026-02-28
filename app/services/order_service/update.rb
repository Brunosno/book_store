module OrderSerive
    class Update < ApiController
        def initialize(order_id, params)
            @order_id = order_id
            @params = params
        end

        def call
            update_order(@order_id, @params)
        end

        private

        def update_order(order_id, params)
            order = Order.find_by(id: order_id)

            if order
                order.update(params)
            else
                raise ActiveRecord::RecordNotFound, "Order with #{order_id} not found"
            end
        end
    end
end