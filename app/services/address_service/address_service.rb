module AddressService
  class AddressService < ApplicationService
    def initialize(address_model = Address)
      @address_model = address_model
    end

    def find_address_by_id(address_id)
      Show.call(address_id)
    end

    def find_addresses_by_user_id(user_id)
      addresses = @address_model.where(person_id: user_id)
      if addresses.any?
        addresses
      else
        raise ActiveRecord::RecordNotFound, "No addresses found for user with id #{user_id}"
      end
    end

    def create_address(params, user_id)
      Create.call(params, user_id)
    end

    def update_address(params, address_id)
      Update.call(params, address_id)
    end

    def delete_address(address_id)
      address = @address_model.find_by(id: address_id)
      address.destroy
    end
  end
end