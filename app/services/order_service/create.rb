module OrderService
  class Create < ApplicationService
    def initialize(params, user_id)
      @params = params
      @user_id = user_id
    end

    def call
      order = Order.new(@params)
      order.user_id = @user_id

      ActiveRecord::Base.transaction do
        calculate_total(order)
        order.save!
      end

      to_dto(order)
    end

    private

    def calculate_total(order)
      total = 0

      order.order_items.each do |item|
        book = item.book
        raise ActiveRecord::RecordNotFound, "Book not found" unless book

        if book.stock < item.quantity
          raise BusinessError, "Insufficient stock for #{book.title}"
        end

        item.unit_price = book.price

        book.stock -= item.quantity
        book.save!

        total += item.quantity * item.unit_price
      end

      order.total = total
    end

    def to_dto(order)
      {
        id: order.id,
        status: order.status_order,
        total: order.total,
        created_at: order.created_at,
        user: {
          id: order.user.id,
          name: order.user.name
        },
        address: {
          street: order.address.street,
          city: order.address.city,
          state: order.address.state,
          zip_code: order.address.zip_code
        },
        items: order.order_items.map do |item|
          {
            book_id: item.book.id,
            title: item.book.title,
            quantity: item.quantity,
            unit_price: item.book.price,
            subtotal: item.quantity * item.book.price
          }
        end
      }
    end
  end
end