module AddressService
  class Update < ApplicationService
    def initialize(address_id, params)
      @address_id = address_id
      @params = params
    end

    def call
      update_address(@address_id, @params)
    end

    private

    def update_address(address_id, params)
        address = Address.find_by(id: address_id)

        if address.update(params)
            address
        else
            raise ActiveRecord::RecordInvalid.new(address)
        end
    end
  end
end