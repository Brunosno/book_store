module AddressService
  class Show < ApplicationService
    def initialize(address_id)
      @address_id = address_id
    end

    def call
      find_address_by_id(@address_id)
    end

    private

    def find_address_by_id(address_id)
        address = Address.find_by(id: address_id)
        if address
        address
        else
        raise ActiveRecord::RecordNotFound, "Address with id #{address_id} not found"
        end
    end
  end
end