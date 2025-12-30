class AddressService
  def initialize(address_model = Address)
    @address_model = address_model
  end

  def find_all_addresses
    return @address_model.all
  end

  def find_address_by_id(address_id)
    address = @address_model.find_by(id: address_id)
    if address
      return address
    else
      raise ActiveRecord::RecordNotFound, "Address with id #{address_id} not found"
    end
  end

  def create_address(params, person_id)
    address = @address_model.new(params)

    if address.save
      return address
    else
      raise ActiveRecord::RecordInvalid.new(address)
    end
  end

  def update_address(address_id, params)
    address = @address_model.find_by(id: address_id)
    if address.update(params)
      return address
    else
      raise ActiveRecord::RecordInvalid.new(address)
    end
  end

  def delete_address(address_id)
    address = @address_model.find_by(id: address_id)
    address.destroy
  end
end