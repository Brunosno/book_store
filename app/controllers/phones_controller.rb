class PhonesController < ApplicationController
  def index
    render json: Phone.all, status: :ok
  end

  def show
    render json: Phone.find(params[:id]), status: :ok
  end

  def create
    phone = Phone.new(phone_params)
    if phone.save
      render json: phone, status: :created
    else
      render json: phone.errors, status: :unprocessable_entity
    end
  end

  def update
    phone = Phone.find(params[:id])
    if phone.update(phone_params)
      render json: phone, status: :ok
    else
      render json: phone.errors, status: :unprocessable_entity
    end
  end

  def destroy
    phone = Phone.find(params[:id])
    phone.destroy!
    head :no_content
  end

  private
  def phone_params
    params.require(:phone).permit(:ddd, :number, :person_id)
  end
end
