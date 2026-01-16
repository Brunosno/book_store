class OrderService
  def initialize(order_model = Order)
    @order_model = order_model
  end

  def create_order(params)
    order = @order_model.new(params)

    ActiveRecord::Base.transaction do
      calculate_total(order)
      order.save!
    end

    to_dto(order)
  end

  private

  def calculate_total(order)
    order.price = order.order_items.sum do |item|
      item.quantity * item.book.price
    end
  end

  def to_dto(order)
    user = UserService.new.find_user_by_id(order.user_id)
    address = AddressService.new.find_address_by_id(order.address_id)

    {
      id: order.id,
      status: order.status_order,
      total: order.price,
      created_at: order.created_at,
      user: user.name,
      address: {
        street: address.street,
        city: address.city,
        state: address.state,
        zip_code: address.zip_code
      },
      items: order.order_items.map do |item|
        {
          book_id: item.book.id,
          title: item.book.title,
          quantity: item.quantity,
          price: item.book.price
        }
      end
    }
  end
end
