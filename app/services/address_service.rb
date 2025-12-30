class AddressService
  def initialize(address_model = Address)
    @address_model = address_model
  end

  def find_all_addresses
    @address_model.all
  end

  def find_address_by_id(address_id)
    address = @address_model.find_by(id: address_id)
    if address
      address
    else
      raise ActiveRecord::RecordNotFound, "Address with id #{address_id} not found"
    end
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
    address = @address_model.new(params.merge(person_id: user_id))

    if address.save
      address
    else
      raise ActiveRecord::RecordInvalid.new(address)
    end
  end

  def update_address(user_id, params)
    address = find_addresses_by_user_id(user_id).first
    if address.update(params)
      address
    else
      raise ActiveRecord::RecordInvalid.new(address)
    end
  end

  def delete_address(address_id)
    address = @address_model.find_by(id: address_id)
    address.destroy
  end
end