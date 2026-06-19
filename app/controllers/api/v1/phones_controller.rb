module Api
  module V1
    class PhonesController < ApiController
      before_action :authorize_admin!, only: [:index, :show]

      def index
        per_page = [params[:per_page].to_i, 50].min
        per_page = 10 if per_page <= 0

        phones = Phone
                   .page(params[:page])
                   .per(per_page)

        render_success(
          data: phones,
          message: "Phones retrieved successfully",
          meta: pagination_meta(phones)
        )
      end

      def show
        phone = Phone.find(params[:id])

        render_success(
          data: phone,
          message: "Phone retrieved successfully"
        )
      end

      def create
        phone = PhoneService::Create.call(phone_params, current_user.id)

        render_success(
          data: phone,
          message: "Phone created successfully",
          status: :created
        )
      end

      def update
        phone = PhoneService::Update.call(params[:id], phone_params)

        render_success(
          data: phone,
          message: "Phone updated successfully"
        )
      end

      def destroy
        Phone.find(params[:id]).destroy!

        head :no_content
      end

      private

      def phone_params
        params.require(:phone).permit(:ddd, :number)
      end

      def pagination_meta(collection)
        {
          current_page: collection.current_page,
          next_page: collection.next_page,
          prev_page: collection.prev_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count
        }
      end
    end
  end
end