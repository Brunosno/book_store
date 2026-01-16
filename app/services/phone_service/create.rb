module PhoneService
  class Create < ApplicationService
    def initialize(params, user_id)
      @params = params
      @user_id = user_id
    end

    def call
      create_phone(@params, @user_id)
    end

    private

    def create_phone(params, user_id)
      phone = Phone.new(params.merge(person_id: user_id))

      if phone.save
        phone
      else
        raise ActiveRecord::RecordInvalid.new(phone)
      end
    end
  end
end