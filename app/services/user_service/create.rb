module UserService
  class Create < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      create_user(@params)
    end

    private

    def create_user(params)
      user = User.new(convert_to_dto(params))

      if user.save
        if params[:phone].present?
          phone = PhoneService::Create.call(params[:phone], user[:id])

          if phone[:error]
            raise phone[:error]
          end
        end

        if params[:addresses].present?
          params[:addresses].each do |address_params|
            address = AddressService::Create.call(address_params, user[:id])

            if address[:error]
              raise address[:error]
            end
          end
        end
        convert_to_dto_response(user)
      else
        raise ActiveRecord::RecordInvalid.new(user)
      end
    end

    def convert_to_dto(user)
      {
        name: user[:name],
        email: user[:email],
        username: user[:username],
        password: user[:password],
        is_admin: user[:is_admin]
      }.compact
    end

    def convert_to_dto_response(user)
      {
        id: user.id,
        name: user.name,
        email: user.email,
        username: user.username,
        is_admin: user.is_admin
      }
    end
  end
end