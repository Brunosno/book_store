class PhoneService
  def initialize(phone_model = Phone)
    @phone_model = phone_model
  end

  def find_all_phones
    return @phone_model.all
  end

  def find_phone_by_id(phone_id)
    phone = @phone_model.find_by(id: phone_id)
    if phone
      return phone
    else
      raise ActiveRecord::RecordNotFound, "Phone with id #{phone_id} not found"
    end
  end

  def create_phone(params, user_id)
    phone = @phone_model.new(params.merge(person_id: user_id))

    if phone.save
      return phone, status: :created
    else
      raise ActiveRecord::RecordInvalid.new(phone)
    end
  end

  def update_phone(phone_id, params)
    phone = @phone_model.find_by(id: phone_id)
    if phone.update(params)
      return phone
    else
      raise ActiveRecord::RecordInvalid.new(phone)
    end
  end

  def delete_phone(phone_id)
    phone = @phone_model.find_by(id: phone_id)
    phone.destroy
  end
end