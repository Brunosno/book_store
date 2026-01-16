module AddressService
  class Create < ApplicationService
    def initialize(params, user_id)
      @params = params
      @user_id = user_id
    end

    def call
      create_address(@params, @user_id)
    end

    private

    def create_address(params, user_id)
      address = Address.new(params.merge(person_id: user_id))

      if address.save
        address
      else
        raise ActiveRecord::RecordInvalid.new(address)
      end
    end
  end
end
