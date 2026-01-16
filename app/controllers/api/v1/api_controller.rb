module Api
  module V1
    class ApiController < ApplicationController
      include ActionController::MimeResponds

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      protected

      def render_success(data: nil, message: nil, status: :ok)
        render json: {
          success: true,
          message: message,
          data: data
        }, status: status
      end

      def render_error(message:, status: :unprocessable_entity, errors: nil)
        render json: {
          success: false,
          message: message,
          errors: errors
        }, status: status
      end

      private

      def record_not_found(exception)
        render_error(
          message: exception.message,
          status: :not_found
        )
      end

      def record_invalid(exception)
        render_error(
          message: "Erro de validação",
          errors: exception.record.errors.full_messages,
          status: :unprocessable_entity
        )
      end

      def parameter_missing(exception)
        render_error(
          message: exception.message,
          status: :bad_request
        )
      end
    end
  end
end