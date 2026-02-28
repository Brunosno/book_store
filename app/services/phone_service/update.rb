module PhoneService
    class Update < ApplicationService
        def initialize(phone_id, params)
            @phone_id = phone_id
            @params = params
        end

        def call
            update_phone(@phone_id, @params)
        end

        private

        def update_phone(phone_id, params)
            phone = Phone.find_by(id: phone_id)

            if phone
                phone.update(params)
            else
                raise ActiveRecord::RecordNotFound, "Phone with #{phone_id} not found"
            end
        end
    end
end